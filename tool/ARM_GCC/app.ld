/* app.ld 							*/
/* Created on: 2015. 2. 1. 			*/
/*     Author: innocentevil 		*/


MEMORY
{
	APP_CHUNK (xrw) : ORIGIN = 0x0000, LENGTH = 16K
}

SECTIONS 
{
	.data  : 
    {
	    . = ALIGN(4);
        /* This is used by the startup in order to initialize the .data secion */
        _sdata = . ;
        
        *(.data)
        *(.data.*)

	    . = ALIGN(4);
	    /* This is used by the startup in order to initialize the .data secion */
	    _edata = . ;
    } >APP_CHUNK
    
	.text :
	{
		. = ALIGN(4);
		_stext = . ;
		*(.text)                   /* remaining code */
        *(.text.*)                 /* remaining code */
 /*       *(.iplt)
        *(.rel.iplt) */
        *(.rodata)                 /* read-only data (constants) */
        *(.rodata*)
	    . = ALIGN(4);
	} > APP_CHUNK
	
	.ROarraySection :
    {
    	*(.ROarraySection)                          
    } >APP_CHUNK
    
    .bss :
    {
	    . = ALIGN(4);
        /* This is used by the startup in order to initialize the .bss secion */
        _sbss = .;
        
        *(.bss)
        *(.bss.*)
        *(COMMON)
        
	    . = ALIGN(4);
	    /* This is used by the startup in order to initialize the .bss secion */
	    _ebss = . ;
    } >APP_CHUNK
}