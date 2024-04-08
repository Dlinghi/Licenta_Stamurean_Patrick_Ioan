// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2.1 (win64) Build 4081461 Thu Dec 14 12:24:51 MST 2023
// Date        : Wed Apr  3 19:54:09 2024
// Host        : Patrick running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/patri/Desktop/Licenta_1/Licenta_1.gen/sources_1/bd/Licenta_Design/ip/Licenta_Design_blk_mem_gen_0_0/Licenta_Design_blk_mem_gen_0_0_sim_netlist.v
// Design      : Licenta_Design_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "Licenta_Design_blk_mem_gen_0_0,blk_mem_gen_v8_4_7,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_7,Vivado 2023.2.1" *) 
(* NotValidForBitStream *)
module Licenta_Design_blk_mem_gen_0_0
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
  Licenta_Design_blk_mem_gen_0_0_blk_mem_gen_v8_4_7 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 52880)
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
