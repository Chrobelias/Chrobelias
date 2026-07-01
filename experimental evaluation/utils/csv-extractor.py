# This is a small Python script to extract to csv the results of the experimental evaluation 
# It assumes that there is a folder containing a bunch of file named <something>.par, 
# each containing the output of a single run on a single instance.

# The usage is:  python csv-extractor.py <results_dir> <output.csv> <max_time> 
# where <results_dir> is the folder containing the .par files, 
#       <output.csv> is the name of the output csv file, and 
#       <max_time> is the maximum time allowed for a run (used to detect timeouts).

import csv
import os
import sys

VALID_OUTPUTS = {
    "sat",
    "unsat",
}

def extract_instance(command_line):
    # Instance is the last token of the command
    return command_line.strip().split()[-1]

def is_number(s):
    try:
        float(s)
        return True
    except (ValueError, TypeError):
        return False

def main(results_dir, output_csv, max_time):
    rows = []

    for filename in sorted(os.listdir(results_dir)):
        if not filename.endswith(".par"):
            continue

        path = os.path.join(results_dir, filename)

        with open(path, "r", encoding="utf-8", errors="ignore") as f:
            lines = [line.strip() for line in f if line.strip()]

        if not lines:
            continue

        # First line: instance
        instance = extract_instance(lines[0])

        output = "timeout"
        time = max_time

        error_msg = ""

        if len(lines) > 1:
            # Last line is time
            if is_number(lines[-1]):
                time = lines[-1]

            # Search for exact output match
            for line in lines[1:]:
                if error_msg != "" :
                    error_msg = error_msg + " :: " + line
                else:
                    error_msg = line

                if line in VALID_OUTPUTS:
                    output = line
                    break

            if time != max_time and output == "timeout":
                output = "unknown"

        rows.append([instance, output, time])

    with open(output_csv, "w", newline="") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(["instance", "output", "time"])
        writer.writerows(rows)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python csv-extractor.py <results_dir> <output.csv> <max_time>")
        sys.exit(1)

    main(sys.argv[1], sys.argv[2], sys.argv[3])
