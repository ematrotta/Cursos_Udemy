const imagenes = document.querySelectorAll('.propiedad__imagen');

// Window es la que contiene las propiedades y los metodos que conciernen al scroll
window.addEventListener('scroll',() => {
    const scroll = this.scrollY / 20;

    imagenes.forEach((imagen)=>{

        imagen.style.backgroundPositionY = `${scroll}px`;

    })
})