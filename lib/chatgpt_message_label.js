document.querySelectorAll('.chatgpt-deep-label').forEach(e=>{
    e.addEventListener("click",ev=>{
        ev.preventDefault();
        t=document.querySelector(`.chatgpt-control + label[for=${e.attributes["for"].value}]`);
        if(t) t.click();
        if(e.parentElement.classList.contains("chatgpt-target")) {
            e.parentElement.click();
        }
    })
});
