/******************************************************************************
* Copyright (C) 2022 Xilinx, Inc.  All rights reserved.
* Copyright (c) 2022 - 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

/*****************************************************************************/
/**
*
* @file xwdttb_config.h
* @addtogroup wdttb Overview
* @{
*
* The xwdttb_config.h file contains the required functions of the XWdtTb driver.
* See xwdttb.h for a description of the driver.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- ---------------------------------------------------------
* 5.0   sne  11/19/19 First release
*
* </pre>
*
******************************************************************************/
/***************************** Include Files *********************************/
/** @cond INTERNAL */
#ifndef XWDTTB_CONFIG_H                /**< prevent circular inclusions */
#define XWDTTB_CONFIG_H                /**< by using protection macros */

#include "xwdttb.h"

#ifdef __cplusplus
extern "C" {
#endif

/************************** Function Prototypes ******************************/

/*
 * Required functions in xwdttb_help.c
 */

s32 XWdtTb_DisableWinWdt(XWdtTb *InstancePtr);
void XWdtTb_EnableTimebaseWdt(XWdtTb *InstancePtr);
s32 XWdtTb_DisableTimebaseWdt(XWdtTb *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
/** @endcond */
/** @} */
