#!/usr/bin/env python3
"""Make the paper's result tables and plots from the res-*.tsv files.

    python3 scripts/make_tables.py OUT_DIR RESULTS_DIR [RESULTS_DIR ...]

RESULTS_DIR: directories with the res-*.tsv files written by
.github/workflows/run-benchmarks.sh (e.g. results results-extra).
OUT_DIR receives

  table-eia.tex         Sierpinski, LoAT, PURRS: sat | unsat per configuration
  table-slia.tex        Hash2, StringFuzz, REln, RElnC (REln/RElnC summed over
                        the number of variables), same layout
  table-reln-vars.tex   REln and RElnC split by the number of variables
  table-fullstrint.tex  FullStrInt, if results for it are given
  table-stages.tex      Chrobelias: decided instances, decided by the NFA
                        Solver, decided by no other solver, and of those by
                        the NFA Solver
  cactus-eia.pdf, cactus-slia.pdf   wall time per solved instance (needs
                        matplotlib; skipped without it)
  summary.csv           one line per configuration and benchmark subset

The tables use the macros of macros.tex (\\restab, \\chros, \\chrod, \\cvcF,
\\ostrich, \\zT, \\noodler, \\swine, famA..famE) and can be \\input directly.
The best sat and the best unsat count of each row are set in bold.
"""
import collections
import csv
import glob
import os
import re
import sys

DECIDED = ('sat', 'unsat')

# Configuration label -> (column heading, order).  Labels come from
# run-benchmarks.sh: the executable name and its flags joined by '_'.
CONFIGS = {
    'chro_-q': (r'\chros', 0),
    'chro_-q_-no-str-under_-no-parallel': (r'\chrod', 1),
    'chro-v1.1.4_-q': (r'\texttt{v1.1.4}', 2),
    'swine': (r'\swine', 3),
    'cvc5': (r'\cvcF', 4),
    'ostrich2': (r'\ostrich', 5),
    'z3': (r'\zT', 6),
    'z3-noodler': (r'\noodler', 7),
}
MAIN_CHRO = 'chro_-q'
SINGLE = 'chro_-q_-no-str-under_-no-parallel'


def classify(path):
    """(family, subset, number of variables or None) of a benchmark path."""
    p = path.replace('\\', '/')
    m = re.search(r'QF_EIA/SIERPINSKI/([^/]+)/', p)
    if m:
        return ('Sierpinski', {'standard': 'Standard', 'big': 'Big'}.get(m.group(1), m.group(1)), None)
    m = re.search(r'QF_EIA/LoAT/([^/]+)/', p)
    if m:
        sub = {'CHC_Comp_22_LIA_Lin': "CHC'22\\_LIA\\_Lin", 'CHC_Comp_23_LIA_Lin': "CHC'23\\_LIA\\_Lin",
               'TPDB_ITS_Complexity': 'Complexity', 'TPDB_ITS_Termination': 'Termination'}
        return ('LoAT', sub.get(m.group(1), m.group(1)), None)
    if '/QF_EIA/PURRS/' in p or p.startswith('QF_EIA/PURRS/'):
        return ('PURRS', None, None)
    m = re.search(r'QF_SLIA/Hash2/([^/]+)/', p)
    if m:
        sub = {'original': 'original', 'original_long': 'long', 'generated': 'gen',
               'generated_long': 'gen long', 'generated_hard': 'z3-hard', 'original_large': 'original, $>$1000'}
        return ('Hash2', sub.get(m.group(1), m.group(1)), None)
    m = re.search(r'QF_SLIA/stringfuzz/(generated|transformed)/([^/]+)/', p)
    if m:
        sub = m.group(2)
        if 'regex' in sub:
            sub = '*regex*'
        return ('StringFuzz', sub, None)
    m = re.search(r'QF_SLIA/StrRElnc/(REln|RElnc)/([^/]+)/[^/]*_v(\d+)_', p)
    if m:
        return ({'REln': 'REln', 'RElnc': 'RElnC'}[m.group(1)], m.group(2), int(m.group(3)))
    m = re.search(r'QF_SLIA/FullStrInt/py-conbyte_([^/]+)/', p)
    if m:
        return ('FullStrInt', m.group(1), None)
    return (None, None, None)


FAMILY_TEX = {'Sierpinski': r'\sier', 'LoAT': r'\loat', 'PURRS': r'\purrs', 'Hash2': r'\hash',
              'StringFuzz': r'\textsc{StrFuzz}', 'REln': r'\reln', 'RElnC': r'\relnc',
              'FullStrInt': r'\fullstr'}
FAMILY_COLOR = {'Sierpinski': 'famA', 'LoAT': 'famB', 'PURRS': 'famC', 'Hash2': 'famA',
                'StringFuzz': 'famB', 'REln': 'famC', 'RElnC': 'famD', 'FullStrInt': 'famE'}
SUBSET_ORDER = {
    'Sierpinski': ['Standard', 'Big', '250'],
    'LoAT': ["CHC'22\\_LIA\\_Lin", "CHC'23\\_LIA\\_Lin", 'Complexity', 'Termination'],
    'PURRS': [None],
    'Hash2': ['original', 'long', 'gen', 'gen long', 'z3-hard', 'original, $>$1000'],
    'StringFuzz': ['*regex*', 'variants', 'amazon', 'z3str2'],
    'REln': ['random', 'z3-hard', 'long'],
    'RElnC': ['random', 'z3-hard', 'long'],
    'FullStrInt': ['cvc4', 'trauc', 'z3seq', 'z3str'],
}


def load(dirs):
    """res[label][file] = (verdict, stage, wall)."""
    res = collections.defaultdict(dict)
    for d in dirs:
        for path in sorted(glob.glob(os.path.join(d, 'res-*.tsv'))):
            for line in open(path):
                f = line.rstrip('\n').split('\t')
                if len(f) < 9:
                    continue
                try:
                    wall = float(f[5])
                except ValueError:
                    wall = float('nan')
                res[f[0]][os.path.normpath(f[2])] = (f[3], f[4], wall)
    return res


def configs_for(res, files):
    labels = [l for l in res if any(f in res[l] for f in files)]
    return sorted(labels, key=lambda l: (CONFIGS.get(l, ('', 99))[1], l))


def heading(label):
    return CONFIGS.get(label, (r'\texttt{%s}' % label.replace('_', r'\_'), 99))[0]


def counts(res, label, files):
    """(sat, unsat), or None if the configuration has no result for these files."""
    if not any(f in res[label] for f in files):
        return None
    c = collections.Counter(res[label][f][0] for f in files if f in res[label])
    return c['sat'], c['unsat']


def bold_if(v, best):
    if v is None:
        return '--'
    return r'\textbf{%d}' % v if best > 0 and v == best else str(v)


def make_table(res, groups, caption, label, namew=72):
    """groups: list of (family, [(subset_name, files)]); one sat|unsat pair per configuration."""
    allfiles = [f for _, rows in groups for _, fs in rows for f in fs]
    cfgs = configs_for(res, allfiles)
    if not cfgs:
        return ''
    n = len(cfgs)
    pair = r'>{\raggedleft\arraybackslash}p{\satw}|>{\raggedright\arraybackslash}p{\unsw}'
    out = []
    out.append(r'\begin{table}[t]')
    out.append(r'    \centering')
    out.append(r'    \caption{%s}\label{%s}' % (caption, label))
    out.append(r'    \restab{\scriptsize}\setlength{\satw}{21pt}\setlength{\unsw}{21pt}')
    out.append(r'    \begin{tabular}{>{\centering\arraybackslash}p{9pt}@{\hspace{2pt}}'
               r'>{\raggedright\arraybackslash}p{%dpt}' % namew + pair * n + '}')
    out.append(r'        \rulecap\toprule\rulebar')
    hd = [r'\multicolumn{2}{@{}l}{\hd{benchmark}}']
    sub = [r'\multicolumn{2}{@{}l}{}']
    for i, c in enumerate(cfgs):
        tint = r'>{\cellcolor{black!10}}' if i % 2 == 0 else ''
        hd.append(r'\multicolumn{2}{%sc}{\scriptsize %s}' % (tint, heading(c)))
        cell = r'\cellcolor{black!10}' if i % 2 == 0 else ''
        sub.append(cell + r'\tiny\textit{sat} & ' + cell + r'\tiny\textit{unsat}')
    out.append('        ' + ' & '.join(hd) + r' \\')
    out.append('        ' + ' & '.join(sub) + r' \\')
    out.append(r'        \rulecap\midrule\rulebar')
    for gi, (fam, rows) in enumerate(groups):
        col = FAMILY_COLOR.get(fam, 'famA')
        nrows = len(rows)
        for ri, (name, files) in enumerate(rows):
            cs = [counts(res, c, files) or (None, None) for c in cfgs]
            bs = max([s for s, _ in cs if s is not None] or [0])
            bu = max([u for _, u in cs if u is not None] or [0])
            famcell = r'\cellcolor{%s!9}' % col
            if ri == nrows - 1 and nrows > 1:
                famcell += r'\multirow{-%d}{*}{\rotatebox[origin=c]{90}{%s}}' % (nrows, FAMILY_TEX.get(fam, fam))
            if name is None:
                shown = r'\hd{%s}' % FAMILY_TEX.get(fam, fam)
            elif nrows == 1:
                shown = r'\hd{%s} %s' % (FAMILY_TEX.get(fam, fam), name)
            else:
                shown = name
            namecell = r'\cellcolor{%s!9}%s\,{\tiny(%d)}' % (col, shown, len(files))
            cells = [famcell, namecell]
            for i, (s, u) in enumerate(cs):
                t = r'\cellcolor{%s!6}' % col if i % 2 == 0 else ''
                cells.append(t + bold_if(s, bs))
                cells.append(t + bold_if(u, bu))
            out.append('        ' + ' & '.join(cells) + r' \\')
        if nrows > 1:
            fam_files = [f for _, fs in rows for f in fs]
            tot = [sum(counts(res, c, fam_files)) if counts(res, c, fam_files) else None for c in cfgs]
            bt = max([t for t in tot if t is not None] or [0])
            out.append(r'        \rulecap\cmidrule{2-%d}\rulebar' % (2 + 2 * n))
            cells = [r'\cellcolor{%s!9}' % col, r'\cellcolor{%s!9}\hd{solved}\,{\tiny(%d)}' % (col, len(fam_files))]
            for i, t in enumerate(tot):
                tint = r'>{\cellcolor{%s!6}}' % col if i % 2 == 0 else ''
                cells.append(r'\multicolumn{2}{%sc}{%s}' % (tint, bold_if(t, bt)))
            out.append('        ' + ' & '.join(cells) + r' \\')
        out.append(r'        \rulecap%s\rulebar' % (r'\bottomrule' if gi == len(groups) - 1 else r'\cmidrule{1-%d}' % (2 + 2 * n)))
    out.append(r'    \end{tabular}')
    out.append(r'\end{table}')
    return '\n'.join(out) + '\n'


def group_files(res):
    """by[(family, subset, vars)] = sorted files seen in any configuration."""
    by = collections.defaultdict(set)
    for lab in res:
        for f in res[lab]:
            fam, sub, v = classify(f)
            if fam:
                by[(fam, sub, v)].add(f)
    return by


def rows_for(by, fam, split_vars=False):
    rows = []
    subsets = SUBSET_ORDER.get(fam, [])
    present = sorted({k[1] for k in by if k[0] == fam}, key=lambda s: subsets.index(s) if s in subsets else 99)
    if not split_vars:
        for s in present:
            files = sorted(f for k, fs in by.items() if k[0] == fam and k[1] == s for f in fs)
            rows.append((s, files))
    else:
        for v in sorted({k[2] for k in by if k[0] == fam}):
            for s in present:
                files = sorted(f for k, fs in by.items() if k == (fam, s, v) for f in fs)
                if files:
                    rows.append(('%s, %d var' % (s, v), files))
    return rows


def stage_table(res, by):
    others = [l for l in res if not l.startswith('chro')]
    fams = ['Sierpinski', 'LoAT', 'PURRS', 'Hash2', 'REln', 'RElnC', 'StringFuzz', 'FullStrInt']
    lines = []
    csv_rows = []
    for fam in fams:
        for s, files in rows_for(by, fam):
            if MAIN_CHRO not in res:
                continue
            r = res[MAIN_CHRO]
            dec = [f for f in files if f in r and r[f][0] in DECIDED]
            nfa = [f for f in dec if r[f][1] == 'nfa']
            only = [f for f in dec if all(not (f in res[o] and res[o][f][0] in DECIDED) for o in others)]
            only_nfa = [f for f in only if r[f][1] == 'nfa']
            if SINGLE in res and any(f in res[SINGLE] for f in files):
                single = str(sum(1 for f in files if f in res[SINGLE] and res[SINGLE][f][0] in DECIDED))
            else:
                single = '--'
            name = FAMILY_TEX[fam] + (' ' + s if s else '')
            lines.append((name, len(files), len(dec), len(nfa), len(only), len(only_nfa),
                          single if SINGLE in res else None))
            csv_rows.append((fam, s or '', len(files), len(dec), len(nfa), len(only), len(only_nfa),
                             single if SINGLE in res else ''))
    out = [r'\begin{table}[t]', r'    \centering',
           r'    \caption{Instances decided by \chros: in total, by the NFA Solver, and by no other solver'
           + (r'; \chrod{} runs as one process without string enumeration' if SINGLE in res else '') + '}',
           r'    \label{tab:stages}', r'    \scriptsize',
           r'    \begin{tabular}{lrrrrr' + ('r' if SINGLE in res else '') + '}', r'        \toprule',
           r'        benchmark & instances & decided & by NFA & only \chros & of these by NFA'
           + (r' & \chrod' if SINGLE in res else '') + r' \\', r'        \midrule']
    for name, n, d, nf, o, onf, sg in lines:
        out.append('        %s & %d & %d & %d & %d & %d%s \\\\' % (name, n, d, nf, o, onf, ' & %s' % sg if sg is not None else ''))
    out += [r'        \bottomrule', r'    \end{tabular}', r'\end{table}']
    return '\n'.join(out) + '\n', csv_rows


def cactus(res, by, fams, title, path):
    try:
        import matplotlib
        matplotlib.use('Agg')
        import matplotlib.pyplot as plt
    except ImportError:
        print('matplotlib not available: skipping', path)
        return
    files = [f for k, fs in by.items() if k[0] in fams for f in fs]
    if not files:
        return
    cfgs = configs_for(res, files)
    plt.rcParams.update({'font.size': 8, 'font.family': 'serif'})
    fig, ax = plt.subplots(figsize=(4.8, 2.4))
    names = {'chro_-q': 'Chrobelias', SINGLE: 'Chrobelias (1 process, no enumeration)',
             'chro-v1.1.4_-q': 'Chrobelias v1.1.4', 'swine': 'SwInE', 'cvc5': 'cvc5',
             'ostrich2': 'OSTRICH2', 'z3': 'Z3', 'z3-noodler': 'Z3-Noodler'}
    styles = ['-', '--', ':', '-.']
    for i, c in enumerate(cfgs):
        times = sorted(res[c][f][2] for f in files if f in res[c] and res[c][f][0] in DECIDED)
        ax.plot(range(1, len(times) + 1), times, styles[i % 4], linewidth=1.2, label=names.get(c, c))
    ax.set_yscale('log')
    ax.set_xlabel('instances decided (%s, %d instances)' % (title, len(files)))
    ax.set_ylabel('wall time per instance (s)')
    ax.axhline(60, color='grey', linewidth=0.5)
    ax.legend(frameon=False, fontsize=7)
    fig.tight_layout()
    fig.savefig(path)
    plt.close(fig)


def main():
    out_dir = sys.argv[1]
    dirs = sys.argv[2:]
    os.makedirs(out_dir, exist_ok=True)
    res = load(dirs)
    by = group_files(res)

    eia = [(fam, rows_for(by, fam)) for fam in ('Sierpinski', 'LoAT', 'PURRS')]
    eia = [g for g in eia if g[1]]
    slia = [(fam, rows_for(by, fam)) for fam in ('Hash2', 'StringFuzz', 'REln', 'RElnC')]
    slia = [g for g in slia if g[1]]
    vars_ = [(fam, rows_for(by, fam, split_vars=True)) for fam in ('REln', 'RElnC')]
    vars_ = [g for g in vars_ if g[1]]
    fsi = [g for g in [('FullStrInt', rows_for(by, 'FullStrInt'))] if g[1]]

    for name, groups, cap, lab, w in (
            ('table-eia.tex', eia, r'\eia benchmarks', 'tab:eia', 96),
            ('table-slia.tex', slia, r'\slia benchmarks', 'tab:slia', 72),
            ('table-reln-vars.tex', vars_, r'\reln and \relnc by the number of variables', 'tab:reln-vars', 84),
            ('table-fullstrint.tex', fsi, r'\fullstr benchmarks', 'tab:fullstrint', 72)):
        if groups:
            open(os.path.join(out_dir, name), 'w').write(make_table(res, groups, cap, lab, w))
            print('wrote', name)

    tex, rows = stage_table(res, by)
    open(os.path.join(out_dir, 'table-stages.tex'), 'w').write(tex)
    print('wrote table-stages.tex')

    cactus(res, by, ('Sierpinski', 'LoAT', 'PURRS'), 'EIA', os.path.join(out_dir, 'cactus-eia.pdf'))
    cactus(res, by, ('Hash2', 'REln', 'RElnC'), 'Hash2, REln, RElnC', os.path.join(out_dir, 'cactus-slia.pdf'))

    with open(os.path.join(out_dir, 'summary.csv'), 'w', newline='') as fh:
        w = csv.writer(fh)
        w.writerow(['config', 'family', 'subset', 'vars', 'instances', 'sat', 'unsat', 'unknown',
                    'timeout', 'wall_s_decided'])
        for lab in sorted(res):
            for (fam, sub, v), files in sorted(by.items(), key=lambda x: (x[0][0], str(x[0][1]), x[0][2] or 0)):
                c = collections.Counter(res[lab][f][0] for f in files if f in res[lab])
                if not c:
                    continue
                t = sum(res[lab][f][2] for f in files if f in res[lab] and res[lab][f][0] in DECIDED)
                w.writerow([lab, fam, sub or '', v or '', len(files), c['sat'], c['unsat'],
                            c['unknown'], c['timeout'], '%.1f' % t])
    with open(os.path.join(out_dir, 'stages.csv'), 'w', newline='') as fh:
        w = csv.writer(fh)
        w.writerow(['family', 'subset', 'instances', 'chro_decided', 'by_nfa', 'only_chro',
                    'only_chro_by_nfa', 'single_process_decided'])
        w.writerows(rows)
    print('wrote summary.csv, stages.csv')


if __name__ == '__main__':
    main()
