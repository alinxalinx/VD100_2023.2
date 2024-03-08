Chapter 4 LVDS LCD screen display experiment
=============================================

**The experimental Vivado project is "lvds_lcd".**

This chapter introduces the color bar display of lvds lcd LCD screen.

.. _Hardware Introduction-1:

Hardware introduction
--------------------------

ALINX black gold 7-inch LCD screen module (AN7000) uses IVO's 7-inch TFT LCD screen.
The model number of the LCD screen is M070AWAD R0. AN7000 LCD screen module is made of TFT
It consists of an LCD screen and a driver board. For specific parameters, please refer to the AN7000 user manual. The actual photos of AN7000 are as follows:

.. image:: images/media/image119.png
  :alt: \_K4A5291
  :width: 5.37431in
  :height: 3.34722in

AN7000 LCD screen front view

programming
---------------

1) Like PL’s “Hello World” LED experiment, add a block
design, and add the CIPS core and configure it as PL Subsystem

.. image:: images/media/image120.png
  :width: 2.17639in
  :height: 1.05556in

2. Add LVDS LCD controller IP

.. image:: images/media/image121.png
  :width: 1.78542in
  :height: 1.19028in

3. Add Advanced IO Wizard and configure

.. image:: images/media/image122.png
  :width: 4.32222in
  :height: 3.34167in

.. image:: images/media/image123.png
  :width: 4.3in
  :height: 2.89028in

.. image:: images/media/image124.png
  :width: 4.62847in
  :height: 2.30694in

4. Connect as follows

.. image:: images/media/image125.png
  :width: 5.68681in
  :height: 2.65486in

5. Add the color bar file, drag it to the block design, and connect it

.. image:: images/media/image126.png
  :width: 3.91597in
  :height: 1.97222in

Define VIDEO_1280_720 in video_define.v because the LCD resolution is 1280*720

.. image:: images/media/image127.png
  :width: 1.94861in
  :height: 0.59722in

6. Generate HDL file

.. image:: images/media/image128.png
  :width: 2.46181in
  :height: 1.31875in

7. Add some other signals

.. image:: images/media/image129.png
  :width: 5.85069in
  :height: 2.89861in

8. Constraint pins

.. image:: images/media/image130.png
  :width: 2.33611in
  :height: 1.44097in

9. Generate pdi file

.. image:: images/media/image51.png
  :width: 1.8375in
  :height: 0.75069in

Experimental phenomena
-------------------------

Connect the LCD screen, download the program, and you can see the color bar display.

.. image:: images/media/image131.png
  :width: 3.72014in
  :height: 4.87708in

.. image:: images/media/image132.png
  :width: 5.35347in
  :height: 3.80694in
