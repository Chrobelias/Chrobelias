### This folder 

This folder contains data relevant to Section 5.3 of the paper:
- benchmarks: contains all instances used in the experimentals
- Jupyter: contains the Jupyter notebook used to produce the plots in the paper. This notebook also contains additional statistics on the experiments. 

### The Jupyter notebook

To look at the notebook, start by creating a Python virtual environment (if you don't have one already): 

`python -m venv /path/to/new/virtual/environment` 

Activate the environment: 

`source <venv>/bin/activate`

And install (`pip install`) the following dependencies `jupyterlab`, `matplotlib`, `numpy`, `pandas`, `typing`. 

Afterwards, navigate to the folder Jupyter contained in the same directory as this file, and start the notebook with `jupyter notebook`. Your browser will open a page, from which you can open the file `a-notebook.ipynb`. 

Once inside the notebook, you can select `Run -> Run all cells` to compile all the data of the experimentals. This will also regenerate the plots, a copy of which is already located in `Jupyter/plots`. The folder `Jupyter/CSV` contains all CSVs used in the notebook.
