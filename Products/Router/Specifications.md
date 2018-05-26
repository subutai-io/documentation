The Blockchain Router is based on an open architecture with a FOSSH
design available at the GitHub[^1]. It uses the most advanced MPSoC on
the market: Xilinx Zynq UltraScale+ with two SODIMM DDR4 RAM slots; one
for the processing system (PS), the other for the programming logic
(PL): total capacity of 16 GB. The PL has enough logic cells and RAM to
mine Ethereum tokens while the PS functions as a plug-and-play Subutai
PeerOS Appliance and broadband router. Broadband routers are an
essential ingredient in the business of providing Internet services and
the Blockchain Router is built to remain competitive well into the
future with the prevalence of 5G and 100GB Ethernet technologies to
support Subutai’s economy operators.

-   Zynq Ultrascale+ MPSoC:

    -   Quad-Core ARM Cortex-A53 (1.5Ghz)

    -   Dual-Core ARM Cortex-R5 Real Time Processing Unit (600 MHz)

    -   ARM Mali™-400 MP2 Graphics Processing Unit (667 MHz GPU)

-   Programmable Logic side: 154K System Logic cells, 360 DSP slices,
    > 7.6 Mb BRAMs

-   2x DDR4 SODIMM 4-8GB on Processor Subsystem (PS) and Programmable
    > Logic (PL)

-   1x SATA 3.0, 1x USB 3.0 Host Interface, 4x RAID-10 eMMC (256GB each
    > at 800Mb/s)

-   Open source eMMC host controller IP core

-   5+1 RJ45 Ports: 5 Layer 2 Controlled Gigabit Ethernet Switch, 10
    > Gigabit Port

-   1x Wi-Fi 802.11 b/g/n + Bluetooth 4.0 LE Interface

-   1x Raspberry Pi, 1x Arduino Uno R3, and 4x PMOD (FPGA PL Connected)

-   I/Os fully compatible with Raspberry Pi 3, Arduino Uno r3 shields
    > and PMOD pinout.

-   1x Trusted Platform Module 2.0 Security Chip Header (For Wallet Keys
    > & Network HSM)

-   1x Debug UART, 1x Mini Display Adapter, Subutai 6.x Firmware Ready

-   Wide range power input (9-36V), maximum power consumption of 18W

[^1]: [*https://github.com/subutai-io/blockchain-router*](https://github.com/subutai-io/blockchain-router)
