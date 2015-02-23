/*
 * main.c
 *
 *  Created on: 2015. 2. 1.
 *      Author: innocentevil
 */


#include "tch.h"

static int scnt = 1;
int cnt;

static DECLARE_THREADROUTINE(childRoutine);

DECLARE_THREADROUTINE(main){

	cnt = 1;
	int a = 0;
	scnt++;

	tch_threadCfg thcfg;
	thcfg._t_name = "child";
	thcfg._t_routine = childRoutine;
	thcfg.t_heapSize = 0;
	thcfg.t_stackSize = 1 << 9;
	thcfg.t_proior = Normal;

	tch_threadId child = env->Thread->create(&thcfg,NULL);
	env->Thread->start(child);

	while(TRUE){
		a++;
		cnt++;
		env->Thread->sleep(10);
		env->uStdLib->stdio->iprintf("Hello World : %d\n",cnt);
	}
	return tchOK;
}

static DECLARE_THREADROUTINE(childRoutine){

	while(TRUE){
		env->uStdLib->stdio->iprintf("Hello This is Child\n");
		env->Thread->sleep(1);
	}
	return tchOK;
}
