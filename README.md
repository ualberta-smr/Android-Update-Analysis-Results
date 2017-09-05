# icse-2018-mehran-results

This repository contains the results produced by [these scripts](https://github.com/ualberta-se/mehran-android-evolution).
- [plot_data](plot_data) contains csv files produced by the [process_results_charts.py](https://github.com/ualberta-se/mehran-android-evolution/blob/master/python/process_results_charts.py), R scripts for drawing plots, and also PDF files of the plots.
- [subsystem_names](subsystem_names) contains csv files produced by [repo.py](https://github.com/ualberta-se/mehran-android-evolution/blob/master/python/repo.py) script. It contains mutual repositores between corresponding versions of AOSP and CyanogenMod.
- [subsystem_tables](subsystem_tables) contains csv files produced by the [RepositoryAutomation.java](https://github.com/ualberta-se/mehran-android-evolution/blob/master/java/src/ca/ualberta/mehran/androidevolution/repositories/RepositoryAutomation.java) script. Each csv file includes information regarding the three versions (AO, AN and CM) of a subsystem. The line includes the number of method is AO, AN and CM. The last line includes the number of new methods in AN, CM and methods with same signature and different body that are added to both AN and CM; the numebr in paranthesis is the number of identical new methods between CM and AN (same signature and body). The remaining lines between the first and last line constitue the results table for methods in AO, and their status in AN and CM. They layout of the table follows the following format:

|         | Identical | Refactored | ArgumentChanged | Body-only | Deleted | SUM |
|:-------:| :-------: |:--------------:| :---------:| :--------------:| :------:|:--: |
Identical |||||||
Refactored | |  | |  |  | |
ArgumentChanged | |  |  |  | | |
Body-only | |  | |  |  | |
Deleted | |  |  |  |  | |
They might be numbers written in paranthesis for the intersections with the same change type in AN and CM. Those are the number of method that had an identical type of change, as were purged. The number before paranthesis does not include the number in the paranthesis, so the paranthesis can be simply ignored in most cases.