____________________________________________________

 GDROM Explorer - v1.6.3
                        by japanese_cake 2010 - 2016
____________________________________________________


[+] What is GDROM Explorer?
    ~~~~~~~~~~~~~~~~~~~~~

        GDROM Explorer is a small tool that enables you to view and extract data
        from Dreamcast and Naomi disc images.

        Main features:
        - Multiple file format support: GDROM Image (.gdi), Mode 1 binary image (.bin),
          ISO9660 image (.iso) and Padus DiscJuggler (.cdi).
        - IP.BIN/IP0000.BIN viewer
        - Primary Volume Descriptor viewer
        - MR image extraction and conversion
        - Cue sheet creation
        - Sort file creation
        - Extract files (IP.BIN and IP0000.BIN included)
        - Support drag'n drop to extract files to the Windows Explorer
        - Convert GD-DA (raw audio tracks) to CD-DA
        - Encrypt/Decrypt Naomi binary
        - Export GDI for GDEMU

    If you have any ideas for features or improvements, feel free to contact me.

    DotNet framework 3.5 is required (partially tested with Mono).

[+] THANKS TO:
    ~~~~~~~~~~

 - Deunan for his help concerning DES decryption (http://dknute.livejournal.com).
 - Marcus Comstedt for his helpful Dreamcast documentation (http://mc.pp.se/dc).
 - SiZiOUS for his MRTool Core (http://sbibuilder.shorturl.com)

[+] NOTES
    ~~~~~

    -> Non ISO9660 Level 1 compliant GDROM/MIL-CDs (like "bleem!")

       Those GDs/CDs can contain files whose name is not d-character encoding compliant (contains characters
       other than A to Z, 0 to 9 and _). For those files, in order to be able to extract them, invalid
       characters are removed and in the UI, they are highlighted with an orange/red color. If the resulting
       file name is an empty string, it will be renamed to "no_name".

    -> Windows restrictions regarding file extensions

       Windows naming conventions does not allow empty extension (like "file.") for files. However, the
       file names with a trailing dot (".") are valid ISO9660 file names.
       For instance, in "Skies of Arcadia" ISOs, in the root directory, there is the file "DISK1.". When
       extracting this file, the trailing dot is removed. Thus the file "DISK1." becomes "DISK1".
       A workaround exists however. All you need to do is to rename the file yourself using
       a shell command as below: mv DISK "\\?\DISK."

[+] FAQ
    ~~~

    -> What is the file that is highlighted with a blue color in the right side of the explorer?

       In every image there is main program that the system (Dreamcast or Naomi) executes. This program is
       a file and it is located in the root folder of the iso file-system. If you want to create a selfboot
       copy of this image, you should start looking at this file to crack it.

    -> What do I do with a sort file?

       A sort file can be used with mkisofs to optimize disc loading time. Generally, the file order in
       a original GDROM image is optimum and it is convenient to re-use this file order when creating an
       autoboot image. Reminder: "mkisofs [params] -sort sorttxt.txt"

    -> Where can I find DES keys to decrypt my Naomi games?

       Naomi PIC DES keys can be found at guru.mameworld.info/naomi/index.html.

    -> What is the DES key auto-load thing?

       Rather than manually opening a text file to copy the DES key then pasting it in GDROM Explorer
       when prompted, you can create a text file with the DES key inside and let the program
       read the key. The program searches for a key in the files listed below, in the following order:
         1- <image filename without extension>.key
         2- key.txt
       The key format must be a 16 digit hexadecimal number as follow: "0123456789ABCDEF".

    -> What is the difference between .raw and .wav audio tracks?

       ".wav" audio tracks are same as ".raw" ones except that they have a header so that any audio
	   player program can read them.

    -> What is a MR image?

       A MR image is an image encoded in one of SEGA's proprietary formats. This kind of image is usually
       found in the initial program (IP.BIN).

	-> What does the "Export GDI to GDEMU" feature?

       It copies and renames a GDI image file and its track files so that GDEMU recognizes them as a game.
	   It also offers you the possibility to patch the image and thus bypass the region and the VGA checks. For
	   sake of data integrity, GDROM Explorer re-computes and modifies the EDC and ECC data of the sectors
	   being patched of MODE 1 tracks.
	   Both the region-free and the VGA patches apply on the first data track of each density (session). The
	   patches mentioned above modify the 16 first sectors of the first track (IP0000.BIN repeated
	   16 times) plus some specific patches on the third track (flags/region area).

[+] TODO
    ~~~~

 - Command line support
 - CRC/MD5/SHA1 checksums support with TOSEC integration
 - Files preview (GDDA/ADX/PVR/1ST_READ.BIN)
 - Localization support
 - Any ideas?

____________________________________________________

                                  jc.dcdev@gmail.com
                       japanese-cake.livejournal.com
____________________________________________________
