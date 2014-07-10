The Desktop project must be linked against desktopapi.tlb in order to compile.
If the BlackBerry JDE and Desktop Manager are installed in their default locations,
no configuration of the Desktop project is necessary, as it will know where to find
desktopapi.tlb.  Otherwise, follow these instructions before attempting to compile:

1) Locate desktopapi.tlb on your machine.  Its default location is
   C:\Program Files\Research In Motion\BlackBerry.
2) On line 29 of Desktop.idl, change the path argument of the importlib statement
   to reflect the location of desktopapi.tlb.
3) In the Microsoft Visual C++ window, click Project, Settings...
4) In the "Settings For" drop-down list, select "All Configurations".
5) Click the C/C++ tab.
6) In the Category drop-down list, select Preprocessor.
7) Change the path in the "Additional include directories" text box to reflect the
   location of desktopapi.tlb.

The project can now be compiled.