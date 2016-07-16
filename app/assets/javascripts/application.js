// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require clipboard
//= require lodash
//= require moment
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require foundation
//= require modernizr
//= require ractive
//= require backbone
//= require ractive-backbone
//= require_self
//= require_tree .
//= require turbolinks

var Stronglifters = Stronglifters || {};
var ready = function() {
  new Stronglifters.Startup().start();
};
$(document).ready(ready);
$(document).on('turbolinks:load', ready);
