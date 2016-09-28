export function throttle(f, delay){
  var timer = null
  return function(){
    let context = this, args = arguments
    clearTimeout(timer)
    timer = window.setTimeout(() => {
      f.apply(context, args)
    },
    delay || 500)
  }
}
