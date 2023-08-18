/*Semana 01*/
let listaRepositorios = localStorage.getItem('dbRepositorios') ? JSON.parse(localStorage.getItem('dbRepositorios')) : []
const select = document.querySelector('#P3_LML_AGRUPSEMANAL')
const options = select.children;

const btSalvar = document.querySelector('#B56036584827854032')
const btRemover = document.querySelector('#B56036643823854033')

select.addEventListener('change', handleRepositorios);
btSalvar.addEventListener('click', handleSalvarLista);
btRemover.addEventListener('click', () => localStorage.removeItem('dbRepositorios'));
carregarLista()

/*Methods */
function handleRepositorios(e)
{
      
    let val = e.target.value;
    let rep = val.split('-');
    let result = rep[0].replace('[','')
    result = result.replace(']','')
           
     const params = result.split(' ')
     /*
      params[0] --> ID do repositório
      params[1] --> Centro de custo
      params[2] --> tipo do repositório
     */           
           
    console.log(params[0],params[1],params[2])
   
    
    apex.item('P3_PARAMS').setValue(params[0])
    //salvarRepositorioTemporario(params[0] + ' ' +params[1] + ' ' + ' '+ params[2] )
    //localStorage.setItem('dbRepositorios', JSON.stringify(listaRepositorios))         
}

function handleSalvarLista(evt)
{
    evt.preventDefault()
    if (listaRepositorios.length > 0)
          listaRepositorios = []
    //alert('Das ist eine klain test')
    console.log(options)
    for(let i=0; i<options.length; i++)
    {
        console.log(options[i].innerHTML)
        listaRepositorios.push(options[i].innerHTML)
    }
    localStorage.setItem('dbRepositorios', JSON.stringify(listaRepositorios))
}

function carregarLista()
{
    if (listaRepositorios.length > 0)
          listaRepositorios.forEach(rep => montarLista(rep))
}

function montarLista(repositorio) {
     let opt = document.createElement('option')
     opt.value = repositorio
     opt.innerText = repositorio
     select.append(opt)
}

//--------------------------------------------------

/*Semana 02*/

let listaRepositorios2 = localStorage.getItem('dbRepositorios2') ? JSON.parse(localStorage.getItem('dbRepositorios2')) : []
const select2 = document.querySelector('#P3_LML_AGRUPSEMANAL_2')
const options2 = select2.children;
const btSalvar2 = document.querySelector('#B56036889515854035')
const btRemover2 = document.querySelector('#B56036934538854036')

select2.addEventListener('change', handleRepositoriosS2);
btSalvar2.addEventListener('click', handleSalvarListaS2);
btRemover2.addEventListener('click', () => localStorage.removeItem('dbRepositorios2'));
carregarListaS2()

function handleRepositoriosS2(e)
{
    let val = e.target.value;
    let rep = val.split('-');
    let result = rep[0].replace('[','')
    result = result.replace(']','')
           
     const params = result.split(' ')
     /*
      params[0] --> ID do repositório
      params[1] --> Centro de custo
      params[2] --> tipo do repositório
     */           
           
    console.log(params[0],params[1],params[2])
    apex.item('P3_PARAMS_2').setValue(params[0])
    
}

function handleSalvarListaS2(evt)
{
    evt.preventDefault()
    if (listaRepositorios2.length > 0)
          listaRepositorios2 = []
    //alert('Das ist eine klain test')
    console.log(options2)
    for(let i=0; i<options2.length; i++)
    {
        console.log(options2[i].innerHTML)
        listaRepositorios2.push(options2[i].innerHTML)
    }
    localStorage.setItem('dbRepositorios2', JSON.stringify(listaRepositorios2))
}

function carregarListaS2()
{
    if (listaRepositorios2.length > 0)
          listaRepositorios2.forEach(rep => montarLista2(rep))
}

function montarLista2(repositorio) {
     let opt = document.createElement('option')
     opt.value = repositorio
     opt.innerText = repositorio
     select2.append(opt)
}

//---------------------------------
/*Semana 03*/
let listaRepositorios3 = localStorage.getItem('dbRepositorios3') ? JSON.parse(localStorage.getItem('dbRepositorios3')) : []
const select3 = document.querySelector('#P3_LML_AGRUPSEMANAL_3')
const options3 = select3.children;
const btSalvar3 = document.querySelector('#B59458914328053704')
const btRemover3 = document.querySelector('#B59459075713053705')

select3.addEventListener('change', handleRepositoriosS3);
btSalvar3.addEventListener('click', handleSalvarListaS3);
btRemover3.addEventListener('click', () => localStorage.removeItem('dbRepositorios3'));
carregarListaS3()

function handleRepositoriosS3(e)
{
    let val = e.target.value;
    let rep = val.split('-');
    let result = rep[0].replace('[','')
    result = result.replace(']','')
           
     const params = result.split(' ')
     /*
      params[0] --> ID do repositório
      params[1] --> Centro de custo
      params[2] --> tipo do repositório
     */           
           
    console.log(params[0],params[1],params[2])
    apex.item('P3_PARAMS_3').setValue(params[0])
    
}

function handleSalvarListaS3(evt)
{
    evt.preventDefault()
    if (listaRepositorios3.length > 0)
          listaRepositorios3 = []
    //alert('Das ist eine klain test')
    console.log(options3)
    for(let i=0; i<options3.length; i++)
    {
        console.log(options3[i].innerHTML)
        listaRepositorios3.push(options3[i].innerHTML)
    }
    localStorage.setItem('dbRepositorios3', JSON.stringify(listaRepositorios3))
}

function carregarListaS3()
{
    if (listaRepositorios3.length > 0)
          listaRepositorios3.forEach(rep => montarLista3(rep))
}

function montarLista3(repositorio) {
     let opt = document.createElement('option')
     opt.value = repositorio
     opt.innerText = repositorio
     select3.append(opt)
}

//Semana 04
let listaRepositorios4 = localStorage.getItem('dbRepositorios4') ? JSON.parse(localStorage.getItem('dbRepositorios4')) : []
const select4 = document.querySelector('#P3_LML_AGRUPSEMANAL_4')
const options4 = select4.children;
const btSalvar4 = document.querySelector('#B59460665864053721')
const btRemover4 = document.querySelector('#B59460727499053722')

select4.addEventListener('change', handleRepositoriosS4);
btSalvar4.addEventListener('click', handleSalvarListaS4);
btRemover4.addEventListener('click', () => localStorage.removeItem('dbRepositorios4'));
carregarListaS4()

function handleRepositoriosS4(e)
{
    let val = e.target.value;
    let rep = val.split('-');
    let result = rep[0].replace('[','')
    result = result.replace(']','')
           
     const params = result.split(' ')
     /*
      params[0] --> ID do repositório
      params[1] --> Centro de custo
      params[2] --> tipo do repositório
     */           
           
    console.log(params[0],params[1],params[2])
    apex.item('P3_PARAMS_4').setValue(params[0])
    
}

function handleSalvarListaS4(evt)
{
    evt.preventDefault()
    if (listaRepositorios4.length > 0)
          listaRepositorios4 = []
    //alert('Das ist eine klain test')
    console.log(options4)
    for(let i=0; i<options4.length; i++)
    {
        console.log(options4[i].innerHTML)
        listaRepositorios4.push(options4[i].innerHTML)
    }
    localStorage.setItem('dbRepositorios4', JSON.stringify(listaRepositorios4))
}

function carregarListaS4()
{
    if (listaRepositorios4.length > 0)
          listaRepositorios4.forEach(rep => montarLista4(rep))
}

function montarLista4(repositorio) {
     let opt = document.createElement('option')
     opt.value = repositorio
     opt.innerText = repositorio
     select4.append(opt)
}