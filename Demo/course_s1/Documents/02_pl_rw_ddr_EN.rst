Chapter 3 PL reads and writes DDR4 experiment through NoC
==========================================================

**The experimental VIvado project is "pl_rw_ddr".**

Hardware introduction
-----------------------

The PL side of the development board has 4 16bit ddr4

.. image:: images/media/image87.png
  :width: 4.39028in
  :height: 2.6in

Vivado project set up
-----------------------

Versal's DDR4 is accessed through NoC, so NoC IP needs to be added for configuration.

Create a Block design and configure the NoC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1) Select Create Block Design

.. image:: images/media/image54.png
  :width: 2.26458in
  :height: 2.29792in

.. image:: images/media/image88.png
  :width: 3.01319in
  :height: 1.87153in

2) Add CIPS

.. image:: images/media/image56.png
  :width: 5.19167in
  :height: 2.67778in

.. image:: images/media/image57.png
  :width: 2.63333in
  :height: 2.09792in

3) Double-click CIPS, select PL_Subsystem, only the logic on the PL side

.. image:: images/media/image58.png
  :width: 4.18542in
  :height: 3.7875in

4) Add NoC IP

.. image:: images/media/image89.png
  :width: 2.42222in
  :height: 2.80486in

5) Configure NoC

Select an AXI Slave and AXI Clock, select "Single Memory Controller"

.. image:: images/media/image90.png
  :width: 5.60972in
  :height: 3.17778in

Select Inputs as PL

.. image:: images/media/image91.png
  :width: 6in
  :height: 1.225in

connection port

.. image:: images/media/image92.png
  :width: 6.01389in
  :height: 1.39028in

DDR4 configuration

.. image:: images/media/image93.png
  :width: 5.39792in
  :height: 3.20069in

.. image:: images/media/image94.png
  :width: 5.99583in
  :height: 2.42569in

Configuration is complete, click OK

6) Configure CIPS and add reset

.. image:: images/media/image95.png
  :width: 1.79444in
  :height: 0.89931in

.. image:: images/media/image96.png
  :width: 3.64028in
  :height: 3.11458in

.. image:: images/media/image97.png
  :width: 3.52014in
  :height: 3.04236in

.. image:: images/media/image98.png
  :width: 2.83056in
  :height: 2.25486in

Click Finish

7) Add Clocking Wizard and configure the output clock to 150MHz as the PL side read and write clock

.. image:: images/media/image99.png
  :width: 1.37014in
  :height: 0.62917in

.. image:: images/media/image100.png
  :width: 5.625in
  :height: 1.73681in

8) Add IBUFDS for NoC and Clocking
Wizard provides a reference clock and exports S00_AXI, CH0_DDR4_0 and other buses, and adds axi_clk and axi_resetn to provide clock and reset for the PL side.

.. image:: images/media/image101.png
  :width: 5.99167in
  :height: 2.18958in

Double-click the reference clock pin and configure the frequency to 200MHz

.. image:: images/media/image102.png
  :width: 2.75208in
  :height: 1.58056in

Double-click the AXI bus and configure

.. image:: images/media/image103.png
  :width: 4.45972in
  :height: 3.44375in

.. image:: images/media/image104.png
  :width: 4.12431in
  :height: 2.81597in

9) Assign address

.. image:: images/media/image105.png
  :width: 5.42708in
  :height: 1.325in

.. image:: images/media/image106.png
  :width: 6.00278in
  :height: 1.41458in

10) Create HDL

.. image:: images/media/image107.png
  :width: 4.37083in
  :height: 1.55972in

Add additional test code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The main function of other codes is to read and write ddr4 and compare whether the data is consistent. I will not introduce it in detail here. You can refer to the engineering code.

.. image:: images/media/image108.png
  :width: 3.17708in
  :height: 2.13056in

1) Add mark_debug debugging in mem_test.v

.. image:: images/media/image109.png
  :width: 3.94143in
  :height: 2.8396in

2) Pin binding

.. image:: images/media/image110.png
  :width: 1.65069in
  :height: 1.32917in

3) Comprehensive

.. image:: images/media/image111.png
  :width: 1.95694in
  :height: 0.85278in

3. After the synthesis is completed, click Set up debug

.. image:: images/media/image112.png
  :width: 1.72292in
  :height: 2.53125in

.. image:: images/media/image113.png
  :width: 3.80139in
  :height: 2.40208in

.. image:: images/media/image114.png
  :width: 3.98681in
  :height: 2.53333in

Set the number of sampling points according to needs

.. image:: images/media/image115.png
  :width: 4.25069in
  :height: 2.7125in

.. image:: images/media/image116.png
  :width: 4.31111in
  :height: 2.74792in

Then save and generate pdi file

.. image:: images/media/image51.png
  :width: 1.8375in
  :height: 0.75069in

Download debugging
--------------------

After generating the pdi file, use JTAG to download it to the development board, and DDR4 calibration and other information will be displayed in the MIG_1 window.

.. image:: images/media/image117.png
  :width: 6.00278in
  :height: 3.32917in

Debug signals can be viewed in hw_ila_1

.. image:: images/media/image118.png
  :width: 6in
  :height: 3.0125in

.. _Experiment Summary-1:

Experiment summary
-----------------------

This experiment directly reads and writes ddr4 through the PL side Verilog code. It mainly understands the configuration method of NoC and how to access DDR4 through NoC. This configuration will be used in subsequent experiments.
