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

ca=attributes camControls
(
	parameters params rollout:ro_camControls
	(
		splineName type: #string ui:edt_spline
	)
	rollout ro_camControls "Mapping Parameters" width:162 height:77
	(
		edittext edt_spline "Path Name"
		button btn_length "UpdateUVs"

		
		on btn_length pressed do
		(
			splineToUse = getNodeByName splineName
			splineLength = curveLength splineToUse
			newLength = splineLength / 85000.0
			setLengthRepeat $ newLength
		)
	)
)--end attributes
 
custAttributes.add $ ca