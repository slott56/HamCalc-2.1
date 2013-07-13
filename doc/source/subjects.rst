###################
Subject Area Index
###################

This list of modules is built from three sources:

1.  The :file:`.BAS` (and :file:`.bas`) files available.

2.  All **DATA** statements that appear to define menus.

3.  The :file:`INDEX/HAMDEX.FIL` with the cross-reference.

See :ref:`legacy` for details of the quirks and issues with these three sources.

-   Some files are not referenced in any menu. In this case,
    we extracted the first REM comment as a description.

-   Some menus name files which don't exist.  We skipped these.

Here's the overall subject area list.

1.  Radio Engineering, "radio"

2.  Radio Operations, "ham"

#.  General Electronics, "electronics"

#.  Construction including Plumbing and Electrical and Mechanical, "construction"

#.  Mathematics and Physics including Unit Conversions, "math"

#.  Navigation and Astronomy, "navigation"

#.  Calendrical Calculations, "calendar"

#.  Audio and Photography, "audio_photo"

#.  Software Engineering, including ASCII codes and other algorithms, "software"

#.  Other, including finance and nutrition, "other"

The idea is to partition all 442 programs in the following list into one of these higher-level subject areas.


Here's the detailed assignment of modules to the above subject areas.
Note that some program files appear to be simple spelling mistakes,
and should probably be removed.

..  csv-table:: Subject Area Index
    :file: menu.csv
    :header: Module,File,Description,Subject,ref,lib,stdio,rest,cli,gui
    :widths: 8, 8, 33, 8, 17, 17, 8, 8, 8, 8
