// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2.1 (win64) Build 4081461 Thu Dec 14 12:24:51 MST 2023
// Date        : Wed Apr  3 19:54:08 2024
// Host        : Patrick running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Licenta_Design_blk_mem_gen_0_0_sim_netlist.v
// Design      : Licenta_Design_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "Licenta_Design_blk_mem_gen_0_0,blk_mem_gen_v8_4_7,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_7,Vivado 2023.2.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    rsta_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  output rsta_busy;

  wire [31:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire rsta;
  wire rsta_busy;
  wire [3:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.3746 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_7 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web({1'b0,1'b0,1'b0,1'b0}));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.2.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
KlreIEsZzn0uSP/9D/ufxHC+XdeNB3Rp8BI1iopwDqZWY2LnU6LdwmOfKqbV5RHI2lmYxZ0DRkF5
dQDDyPtvkr5xpKd4mHw8pIRaCuoIi325TYyZ4mZtew/sj6ihSRoltQmaQarOPDD09PeuMbq8ecc4
WV85hZe43g7mcMbbTbo=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j15cwxZDk4bw/lIMdYg2vWh4KM2Jwj1RvqcY+ixGr+6fKBD/f4kIxZR2uos4I2Vp8+I6EznWbJgn
Y6RbSMx6/VWYcgzA61qGw6Sc2i3+7vuWI4bzWdDsAGOm754iPsUXIzSiCWBShn3ueyU1KLf34OBT
aVPqizER8L+Vajby7qtqi7c9qV8YSAFUu7KLpy5WNSxnMWeASanJYDU91F2HEHZukcLPx5jLVbQw
OBkdbzP8W1Fw4r/HgO70HZAy3/FOoSjZh5h+xS3J/w7F67NZS7kKd10c1tiNJpj6TE98qMw7DFQn
9GjBtjNbFTiteg6uRQKaQQq1ONNMXpwB7utwYQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
H3xUZXdzhF1pUsPzoBc/UFs0dHjuWE6FlQNImwPPSNMppgVRimjThjFsTZHJGZT5Q6wPHLilexER
sJBrm7KaJA/EtDxlcPlNf6uSr7NwxLCWJHI4+UUZUmou/hONJTDyQ7NPVF7e6cfVv+cvp6Q4osDD
IvFefPUl5UCet4pC/Fw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GbfLotE8tiuAo0LPtdX4EdgfdhwUls/WuYf2kXJ25dku9LH+0LoHKO9xKnxQXMI6ZdNz+W9eeQv0
xctfj+/e7BBUir6MTIZn1JntWCoSOcA5nllYxwgOKPddNDj19HuQ69Hc67P2HtX1mkd5BZ0whU5T
hDRzNRZoU0ihPf+VNRdOAbFd+OMpu5Dt/GlzX0I4x3IjrmqqNe4fswlgFyE0Bngd5GzGJHbF/Hih
69H/CPfJQlACUMn4tLLsjhUm2zSHD89D3xTMZIRcgy0tRUrhN2hderFMvZex3czHPVXXHuoMG4DI
wL+MQJf8L3uYhHvW71REgpFAX8q2FPEBu+JdPQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
CLZkA80tepZrgoVGvQ8RsvTvbRbcJYWo4MzQydrlQ5vuZK2GZT1ZpYNX9S6ZfzDVxQ0DQG4Nq7w3
TwYMlZu0YYu0TucAa6A8IYxzWcB0AS15+O5xniGw4P5aOx4OCRNRdHIoN4UjiyASnG+QhFxeZtY8
HaZDJ3EeZXZ1xlPe9C4mAvfe8H4hbSvQ9d3/E8nkw7bknt7jf+zqxU888Lnd+Pb5tuO1jXniz1r2
0PVMglqKadXNh9mhFVVuC7Nckrw+xAZ7a69JBSMmlCOar5Q3e0KXNGrJUW+OS1hJCNYaIVyGowEU
Fz6zfzR/ir/OlaH+iI1ZVSMaKdHrv5G2oXMfpw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BEgl1etvc3H+kX3GaaJ4m5Hx7TXsEMoNGUlLNweK7UABCVqh6geHLWdC3ZR4iTGKp7yTD1CFzLCQ
KbYafcTDi+Auh4GJYnMQ7KZWeo4HhlJEcP8WrZOUJ6/HxpGc61lUtyRV83wuHqlgcaZqkuiseyQF
AVe85UyV/HC7SNVkcVHIN5NrY9LXIOF8mzcj4KpVRA52VCYxISO9Ddk8bojLjd8tsHXofLMPC6l7
wgzk4VVgxAB8bQTOYobkdr2WhndqUgVBIeudzF9jf6OxF2KtStDn0wNvJdU/6ii5M4ZNCHqxWqeg
8AYTqpsmMs2noLyKIc7eQJ9P3H76BzOXpHl38g==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
onsTxmr9leZMdPEkXPYAoaahh6MejdZ+cABzdRPGCDSDlrxzmWDq5F3u3WAgYvyZJsrqmp53UbcC
QdZ/Z+S67/hSTBIV7+YeMLBlYAG7eOvkAVjHS9uKZwVuPUFFRn0dWN2m14DRBNrTakjgUBZotlCJ
zYG7z2eXFh/hHBcx9dKA7PBOPGkzLhqTEVXOheRubxuP1A6tXjRypAO25EfPd22ytlxCzg/y99H7
5CT7ry1htdqXNjvUpnIuq+Tyq1BGb2EauaxybVo/bgc+iQGjfGTdj1LZj0tLKJiGinVhSZe+9os4
WX2B9U2C8BFCpE1jvo76nUiR9lxeRZR97TE3Yg==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
h7dcg8VkOdwzgJApkUqZdCFHbnD9Ks/xXWCsxuKFs1/csamYnM58FaPqnbvDEYV4DkxFm8PDO/ls
W2K9ng/jhkqLQwywf4SN6IRDzF3MFf1mUSm3PiqA1rbQ6NLvHx7SBVVQOCXdeFx/d9ftLoHuxw6j
SUlF7d2ownLhSysrONY8QgrUTDcRwFvh0noZ9FoE//gEdaVDD7qq6rnncUH6NIXZD2QNJ8IgW2EE
ln7EE+92Md8gUTo6vfwF+q4Tl3k/m38ckIW/imfmOaxppQrAQswXHqN5cUv4u0e/dDuT5934ja1H
d3MCHRxmNscOVpNvgySnyTTXVws9twpygdvLMnXAsof5OSMfufvxql+aZOkGYBjtpVwatBDFndUR
iEcLkWxQxaqJ6ulTTO+ALxE6rPs1pOSH0GV48cEoLW2kyMb914+DVew9/AmRYu3rz0uQ7xDF/+Ql
AfxuRP02YBPcMevr0oCqNcpUOaJjkmyG7wKV/7ye59n1jP1D7WjoUMaJ

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
l/O5fpi+++bnBXEsyS4eB3ePsAEEy3fGqR43RuG2/GYX7hddhcZkc/S2i4kZV2ncl0rm3vHOiJ6d
Wql8ox+3bvRw4f3+/R2Jpvxb5nUf4aVLBxgZY9zkvxuqwxkj7o5a+3JZNYDZVQeBUZTsNblHo79n
SmBbtbfc9QTEx1V6ekqtwTIcTg8kDzRDjHcCrvFQp5dc7TeZYK7oJ8/R1o7qiZ/ekDfvpJHEB5QN
MHbg5mE7cE0wSmQMf7/SiZZ+0u6rHIXh56aq4H9xPsR8UPNT6vzPauPXwVy4drZJNkWw802kCzub
1z8ikZ3MYHVCjAp66EXhi0npLJ8owqLcSS7vgA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ZbiJS/yJ/2ChEUUUs/zhPZnydFHl5g230ox7ulrdOmeS05wNlv2XKjPyPjYvxWwxWWR13lYxbI1B
KsAIl1WqiBEmzIQyGnOoh19YB1tnNl3r/ilQ3bUH+E+YUUvXJhNP/RrE7gFQAUq1h5Kxsyov5v5d
b12AX4azJ81Yclmb6glYLU/A/Uc9xZsI8wTKceaR9rEHTzXXzEEKvfDLXZj7bb7oXl7rWJdXCuYp
xz/gyco669pKv9yI7eRsg8tbnXesftEv7fyMJr5UGeYoTwLMnoKGLOzcF28SSbLdtEWUbKHUrjHt
x+0UKWZVtujhxa+ybBDk74+0woxwgEBSJmcvng==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YCuRj74sN8xcBGP8gF6yZ83qYxoB16s6B4faGO3UqeJ0n9Ge7P1Dyec46DdqfSXJ31NG0U84WuZ5
vEbKqZ+e1wG75oueGXZx1g/Bm/RcnkJH13yP3cy0TxuZQH3FfVeX3gP6sJxQpBGH5coAMYa/B679
xHTfAtAShfY0/riweEugdWcK3jTRQkW5vUICfrbbmhV3OCL3HqBHqq/x8wEPzrMfbjXDsxmH4N1V
aDZHTyg+cCthxtbLrQ5KYpVln2nfAXMJh0jbgpA/EPNCbsy2i2MsiRvTpSIKApWPNEQ4gHxCXlml
xpansgG6PYMz7OpRwfisdJ3HEcq4azqJn4zNPg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 52768)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
