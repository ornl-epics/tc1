#!../../bin/linux-x86_64/TC1

## You may have to change TC1 to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"
#Define protocol path
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(QUANTUMNORTHWEST)/protocol/")




## Register all support components
dbLoadDatabase "dbd/TC1.dbd"
TC1_registerRecordDeviceDriver pdbbase
drvAsynIPPortConfigure ("Peltier1","10.112.145.3:4001",0,0,0)


#This prints low level commands and responses
#asynSetTraceMask("Peltier1",0,0x07)
#asynSetTraceIOMask("Peltier1",0,0x07)

## Load record instances
dbLoadRecords(db/TC1QNW1.db)

# autosave

epicsEnvSet IOCNAME CG3-SE-TC1ONE
epicsEnvSet SAVE_DIR /home/controls/var/$(IOCNAME)

save_restoreSet_Debug(0)

### status-PV prefix, so save_restore can find its status PV's.
save_restoreSet_status_prefix("TC1:SE:QNTC1")

set_requestfile_path("$(SAVE_DIR)")
set_savefile_path("$(SAVE_DIR)")

save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(600)
set_pass1_restoreFile("$(IOCNAME).sav")

#####################################################



cd "${TOP}/iocBoot/${IOC}"
iocInit

#This prints low level commands and responses
asynSetTraceMask("Peltier1",0,0x07)
asynSetTraceIOMask("Peltier1",0,0x07)



# Create request file and start periodic 'save'
epicsThreadSleep(5)
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME).req", "autosaveFields")
create_monitor_set("$(IOCNAME).req", 5)



var mediatorVerbosity 7
var mySubDebug 7


