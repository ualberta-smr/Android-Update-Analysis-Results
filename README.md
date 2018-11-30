# Android Update Analysis Results

This repository contains the results produced by the [Android Update Analysis](https://github.com/ualberta-se/Android-Update-Analysis) on 8 versions of LineageOS and their corresponding AOSP versions (cm-10.1, cm-10.2, cm-11.0, cm-12.0, cm-12.1, cm-13.0, cm-14.0, cm-14.1). This data was used in our MSR '18 submission.

The analysis took 14 hours and 25 minutes to execute, on a machine with 128 GB of memory and an AMD Ryzen Threadripper 1950X 16-Core processor.

## File Structure
### [subsystem_tables](subsystem_tables) 
This folder contains output csv files produced by the analysis.

### [process_results_charts.py](process_results_charts.py)
Use this script to create plottable CSV files from the susbsystem tables in the [subsystem_tables](subsystem_tables) folder. To do so, simply uncomment what you want to generate in the `run()` function and run the script.

### [plotting](plotting)
Using the plottable CSVs created with the [process_results_charts.py](process_results_charts.py), you can run the R scripts here to draw 3 different plots. This folder already includes plottable CSV files created from the [subsystem_tables](subsystem_tables).


## Team
- [Mehran Mahmoudi](https://webapps.cs.ualberta.ca/profile/), University of Alberta (Main contact)
- [Sarah Nadi](http://www.sarahnadi.org), University of Alberta
