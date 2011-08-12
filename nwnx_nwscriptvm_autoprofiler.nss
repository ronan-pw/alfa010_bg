/*++

Copyright (c) Ken Johnson (Skywing). All rights reserved.

Module Name:

	nwnx_nwscriptvm_autoprofiler.nss

Abstract:

	This module logs NWScript usage statistics to AuroraServerNWScript.log at
	periodic intervals (by default, 24 hours).

--*/

#include "nwnx_nwscriptvm_include"

//
// Define how long we wait between profile intervals.  The default is one day.
//

const float NWScriptVM_AutoProfiler_Interval = 60.0f * 60.0f * 24.0f;
float NWScriptVM_AutoProfiler_Cycles = 0.0f;

void
NWScriptVM_AutoProfiler_StartNextProfilerCycle(
	);

void
NWScriptVM_AutoProfiler_Continuation(
	)
/*++

Routine Description:

	This routine logs current NWScript usage statistics to the plugin log file.

Arguments:

	None.

Return Value:

	None.

Environment:

	Script DelayCommand continuation.

--*/
{
	NWScriptVM_AutoProfiler_Cycles += 1.0f;

	NWNXGetInt( "NWSCRIPTVM", "LOG SCRIPT STATISTICS", "", 0 );
	WriteTimestampedLogEntry(
		"NWScriptVM: " + IntToString( NWScriptVM_GetAvailableVASpace( ) ) +
		" bytes address space available (autoprofiler active for " +
		FloatToString( NWScriptVM_AutoProfiler_Cycles * NWScriptVM_AutoProfiler_Interval ) +
		" seconds).");

	DelayCommand(
		NWScriptVM_AutoProfiler_Interval,
		NWScriptVM_AutoProfiler_Continuation( ) );
}

void
main(
	)
/*++

Routine Description:

	This routine initiates automatic profiling of scripts.

Arguments:

	None.

Return Value:

	None.

Environment:

	GUI script.

--*/
{
	AssignCommand(
		GetModule( ),
		DelayCommand(
			NWScriptVM_AutoProfiler_Interval,
			NWScriptVM_AutoProfiler_Continuation( ) )
		);
}

