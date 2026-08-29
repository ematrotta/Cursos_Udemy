
// window.swiper = new Swiper({
//     el: '.slider__contenedor',
//     slideClass: 'slider__slide',
//     createElements: true,
//     autoplay:{
//         // Para que se mueva automáticamente cada 5 segundos
//         delay: 5000
//     },
//     // Permite que si ya llegó a la última, retorne a la primera
//     loop:true,
//     // Permite agregar viñetas de página abajo
//     pagination:true,
//     // permite agregar flechas a los lados
//     navigation: {
//         nextEl: ".swiper-button-next",
//         prevEl: ".swiper-button-prev"
//     },
//     effect: "cube"

// });

var swiper = new Swiper('.swiper', {
    effect: 'cube',
    grabCursor: true,
    cubeEffect: {
        shadow: true,
        slideShadows: true,
        shadowOffset: 20,
        shadowScale: 0.94,
    },
    pagination: {
        el: '.swiper-pagination',
    },
});