fn setLengthRepeat o val = (
WM_COMMAND = 0x0111
EN_CHANGE = 0x0300
EN_KILLFOCUS = 0x0200
WM_KILLFOCUS = 0x0008

mainHWND = windows.getDesktopHWND()

setCommandPanelTaskMode #modify
--modPanel.setCurrentObject o
subObjectLevel=0
modPanel.setCurrentObject o.baseObject

children = windows.getChildrenHWND mainHWND
--print children
local LengthRepeatIndex
for i = 1 to children.count do ( if (children[i][5] == "Length Repeat:") then ( LengthRepeatIndex = i ) )

-- Length Repeat spinner edit control is still offset +3?
spinnerEditHWND = children[LengthRepeatIndex+3][1]
spinnerEditParentHWND = UIAccessor.getParentWindow spinnerEditHWND
spinnerEditID = UIAccessor.getWindowResourceID spinnerEditHWND

UIAccessor.setWindowText spinnerEditHWND (val as string)
windows.sendMessage spinnerEditParentHWND WM_COMMAND ((bit.shift EN_CHANGE 16) + spinnerEditID) spinnerEditHWND
windows.sendMessage spinnerEditParentHWND WM_COMMAND ((bit.shift EN_KILLFOCUS 16) + spinnerEditID) spinnerEditHWND
windows.sendMessage spinnerEditHWND WM_KILLFOCUS 0 0
)

ca=attributes "Loft Adjust"
(
	parameters main rollout:params
	(
		sound type:#string
	)
	rollout params "Dudu"
	(
		button btnAdjust "Readjust Length"
	)
	
	on btnAdjust pressed do
	(
		messagebox "FUCK"
	)
		
)

custAttributes.add $ ca
