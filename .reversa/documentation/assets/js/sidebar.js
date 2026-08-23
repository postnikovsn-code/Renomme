/* sidebar.js — мост между панелью управления (aside.reversa-doc-sidebar) и
   визуализациями на странице. Каждый контрол с атрибутом data-param при
   изменении рассылает событие 'reversa:param-change' с detail {param, value}.
   Кнопка data-action="reset" возвращает все контролы к data-default.
   Визуализации (arquitetura, modulos, metricas, topologia) слушают это событие. */
(function(){
  "use strict";

  function controlValue(el){
    if(el.type === 'checkbox') return el.checked;
    if(el.type === 'range' || el.type === 'number'){
      var v = parseFloat(el.value);
      return isNaN(v) ? el.value : v;
    }
    return el.value;
  }

  function emit(param, value){
    document.dispatchEvent(new CustomEvent('reversa:param-change', {
      detail: { param: param, value: value }
    }));
  }

  function wireControl(el){
    var param = el.getAttribute('data-param');
    if(!param) return;
    var evt = (el.tagName === 'SELECT' || el.type === 'checkbox') ? 'change' : 'input';
    el.addEventListener(evt, function(){ emit(param, controlValue(el)); });
  }

  function resetAll(scope){
    var controls = scope.querySelectorAll('[data-param]');
    for(var i=0;i<controls.length;i++){
      var el = controls[i];
      var def = el.getAttribute('data-default');
      if(def === null) continue;
      if(el.type === 'checkbox'){
        el.checked = (def === 'true' || def === '1');
      } else {
        el.value = def;
      }
      emit(el.getAttribute('data-param'), controlValue(el));
    }
  }

  function init(){
    var sidebars = document.querySelectorAll('aside.reversa-doc-sidebar');
    var scope = sidebars.length ? null : document; // fallback to whole doc
    var controls = document.querySelectorAll('[data-param]');
    for(var i=0;i<controls.length;i++){ wireControl(controls[i]); }

    var resets = document.querySelectorAll('[data-action="reset"]');
    for(var r=0;r<resets.length;r++){
      (function(btn){
        btn.addEventListener('click', function(){
          var host = btn.closest('aside.reversa-doc-sidebar') || document;
          resetAll(host);
        });
      })(resets[r]);
    }
  }

  if(document.readyState === 'loading'){
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
