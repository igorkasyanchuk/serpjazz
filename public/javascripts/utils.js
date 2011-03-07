function IconsContainer() {
  this._free = null;
  this._premium = null;
  this._premium_plus = null;
  this.free_icon = function() {
    if (!this._free) {
      var iconOptions = {};
      iconOptions.width = 32;
      iconOptions.height = 32;
      iconOptions.primaryColor = "#FF0000";
      iconOptions.cornerColor = "#FFFFFF";
      iconOptions.strokeColor = "#000000";
      iconOptions.clickable = true;
      this._free = MapIconMaker.createMarkerIcon(iconOptions);
    }
    return this._free;
  };
  this.premium_icon = function() {
    if (!this._premium) {
      var iconOptions = {};
      iconOptions.width = 32;
      iconOptions.height = 32;
      iconOptions.primaryColor = "#0000FF";
      iconOptions.cornerColor = "#FFFFFF";
      iconOptions.strokeColor = "#000000";
      iconOptions.clickable = true;
      this._premium = MapIconMaker.createMarkerIcon(iconOptions);
    }
    return this._premium;
  };
  this.premium_plus_icon = function() {
    if (!this._premium_plus) {
      var iconOptions = {};
      iconOptions.width = 32;
      iconOptions.height = 32;
      iconOptions.primaryColor = "#00FF00";
      iconOptions.cornerColor = "#FFFFFF";
      iconOptions.strokeColor = "#000000";
      iconOptions.clickable = true;
      this._premium_plus = MapIconMaker.createMarkerIcon(iconOptions);
    }
    return this._premium_plus;
  };
  this.init = function() {
    this.free_icon();
    this.premium_icon();
    this.premium_plus_icon();
    return this;
  };
  this.icon = function(plan) {
    if (plan == 2) {
      return this.premium_plus_icon();
    } else if (plan == 1) {
      return this.premium_icon();
    } else {
      return this.free_icon();
    }
  }
};