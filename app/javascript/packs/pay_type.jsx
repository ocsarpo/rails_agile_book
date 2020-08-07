import React                from 'react'
import ReactDOM             from 'react-dom'
import PayTypeSelector      from 'PayTypeSelector'

// 페이지가 그려질 때 마다 리액트가 set up 되도록 함.
document.addEventListener('turbolinks:load', function(){
   var element = document.getElementById("pay-type-component");
   // element를 리액트 컴포넌트로 교체
   // HTML 같은(HTML-like value) <PayTypeSelector />

   ReactDOM.render(<PayTypeSelector />, element );
});