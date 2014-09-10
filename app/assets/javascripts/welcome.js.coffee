# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

classes = ['river', 'waka', 'boat', 'bridge', 'mountains']

rotateSplashBg = ->
  splash = document.querySelector '.splash'
  return unless splash
  active = -1
  for cls, idx in classes
    if splash.classList.contains cls
      active = idx
      splash.classList.remove cls
  nextClass = classes[(active + 1) % classes.length]
  splash.classList.add nextClass
  
setInterval rotateSplashBg, 10000
