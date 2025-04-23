local M = {}
local ethernetInterfaceName = ""
local wifiInterfaceName = "Wi-Fi"
local state = {
  wifiActive = nil,
  wiredActive = nil
}

local function stateChanged(wifiActive, wiredActive)
  return wifiActive ~= state.wifiActive or wiredActive ~= state.wiredActive
end

local function getInterfaceByName(name)
  for _, iface in pairs(hs.network.interfaces()) do
    if (hs.network.interfaceName(iface) == name) then
      return iface
    end
  end

  return nil
end

local function getInterfaceActive(iface)
  if iface == nil then
    return false
  end

  local details = hs.network.interfaceDetails(iface)
  return details.Link and details.Link.Active or false
end

local function toggleWifiIfNecessary()
  local wifiActive = getInterfaceActive(getInterfaceByName(wifiInterfaceName))
  local wiredActive =
    getInterfaceActive(getInterfaceByName(ethernetInterfaceName))
  if (stateChanged(wifiActive, wiredActive) == false) then
    return
  end

  state = {wiredActive = wiredActive, wifiActive = wifiActive}

  if (wiredActive and wifiActive) then
    hs.wifi.setPower(false)
    hs.alert.show("Wired connection active, turning wifi off.")
  elseif (wiredActive == false and wifiActive == false) then
    hs.wifi.setPower(true)
    hs.alert.show("Wired connection cut, turning wifi on.")
  end
end

function M.setEthernetInterfaceName(name)
  ethernetInterfaceName = name
end

function M.setWifiInterfaceName(name)
  wifiInterfaceName = name
end

function M.handleNetworkChange()
  toggleWifiIfNecessary()
end

return M
