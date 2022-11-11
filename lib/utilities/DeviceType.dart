


// using device type we can responsive this app... need to implment



enum Device {
  mobile,
  tab
}


class DeviceType{
  double width;
  DeviceType({required this.width});
  Device getType(){
    if(width >= 600){
      return Device.tab;
    }else{
      return Device.mobile;
    }
  }
}