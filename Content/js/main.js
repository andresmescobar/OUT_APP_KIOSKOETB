function Redirect(pagina) {
    StartTransaccion();
    let url = hostURL + pagina;
    window.location = url;
}