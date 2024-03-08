Chapter 5 GTYP transceiver bit error rate test IBERT experiment
=================================================================

**The experimental VIvado project is "ibert_test", and there is also "ibert_ex" in the directory, which is the generated test project.**

Vidado software provides us with the powerful bit error rate tester IBERT, which can not only test the bit error rate but also test the eye diagram, which brings great convenience to us in using high-speed transceivers. This experiment will serve as a starting point and briefly introduce the IBERT use.

.. _Hardware Introduction-2:

Hardware introduction
---------------------------

To use IBERT to test the bit error rate and eye diagram, you must have transceiver loopback hardware. There are two SFP optical interfaces on the development board. In this experiment, the two optical interfaces are connected in pairs to form two transceiver loopthrough links.

.. _vivado project creation-1:

Vivado project set up
------------------------

1) Create a new project named "ibert_test"

2) Search "gt" in "IP Catalog" to quickly find "Versal ACAPs Transceivers"
Wizard", double-click

.. image:: images/media/image133.png
  :width: 5.99722in
  :height: 1.49167in

3) Change "Component Name" to "ibert" and modify the preset to "Aurora 64B/66B"

.. image:: images/media/image134.png
  :width: 6.00208in
  :height: 3.88889in

4) Click Transceiver Configs Protocol 0, configure the sending and receiving parameters, and click OK

.. image:: images/media/image135.png
  :width: 3.72083in
  :height: 1.70903in

.. image:: images/media/image136.png
  :width: 6.00347in
  :height: 4.52292in

.. image:: images/media/image137.png
  :width: 5.99722in
  :height: 4.48472in

5) Click Generate

.. image:: images/media/image138.png
  :width: 2.625in
  :height: 3.27153in

6) Right-click "Open IP Example Design..." and select the example project path

.. image:: images/media/image139.png
  :width: 3.3875in
  :height: 2.54236in

.. image:: images/media/image140.png
  :width: 3.84653in
  :height: 1.75556in

7) Add buffer to connect to apb3clk

.. image:: images/media/image141.png
  :width: 5.9875in
  :height: 3.14722in

8) Add inverter connected to reset

.. image:: images/media/image142.png
  :width: 5.99514in
  :height: 1.95069in

9) Some other signals are configured as constant 0

.. image:: images/media/image143.png
  :width: 3.93056in
  :height: 3.19722in

10) Delete output signal

.. image:: images/media/image144.png
  :width: 2.025in
  :height: 1.57778in

11) Configure sfp_disable to 0

.. image:: images/media/image145.png
  :width: 4.46458in
  :height: 1.00556in

12) Change CIPS to PL Subsystem

.. image:: images/media/image146.png
  :width: 5.47014in
  :height: 4.74514in

13) Constraint pins

.. image:: images/media/image147.png
  :width: 5.99583in
  :height: 5.09167in

14) Generate pdi file

.. image:: images/media/image148.png
  :width: 1.72431in
  :height: 0.79444in

.. _Download Debug-1:

Download debugging
--------------------

1) Insert the optical module, then use optical fiber to connect the two optical ports, connect the JTAG download cable, and power on the development board

.. image:: images/media/image149.png
  :width: 5.99028in
  :height: 3.39931in

2) Use JTAG to download the BIT file to the development board. You can see that the speed is close to 10.3125Gbps.

.. image:: images/media/image150.png
  :width: 2.70625in
  :height: 3.36528in

3) Select IBERT, right-click and select "Create Links"

.. image:: images/media/image151.png
  :width: 3.33819in
  :height: 1.68889in

Referring to the schematic diagram, the optical fiber is connected to CH0 and CH1 of Quad104. Select Link 0 as Quad_104 CH_0
TX corresponds to CH1 RX, Link 1 corresponds to Quad_104 CH_1 TX and CH0 RX

.. image:: images/media/image152.png
  :width: 5.99931in
  :height: 3.93542in

4) Modify the configuration, select PRBS 31 for the code stream, and configure Loopback to None

.. image:: images/media/image153.png
  :width: 5.99028in
  :height: 0.55903in

5) After configuration, you can click BERT Reset. You can see that the Errors are all 0 and restart the test.

.. image:: images/media/image154.png
  :width: 5.99722in
  :height: 1.33472in

6) Select a link, right-click "Create Scan..."

.. image:: images/media/image155.png
  :width: 3.30208in
  :height: 1.98889in

.. image:: images/media/image156.png
  :width: 3.36944in
  :height: 3.56319in

7) The eye diagram configured by default. Note: The measured eye diagram may be different when using different software versions.

.. image:: images/media/image157.png
  :width: 5.99792in
  :height: 3.05069in
