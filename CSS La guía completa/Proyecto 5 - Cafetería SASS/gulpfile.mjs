// Importaremos los elementos necesarios del módulo de gulp
import { src, dest, watch, series, parallel } from 'gulp';

// CSS y SASS
import gulpSass from 'gulp-sass';
import * as dartSass from 'sass';
import postcss from 'gulp-postcss';
import autoprefixer from 'autoprefixer';
import sourcemaps from 'gulp-sourcemaps';
import cssnano from 'cssnano';

// Imagenes
// Reemplazamos gulp-imagemin y gulp-webp por sharp directamente,
// porque los plugins de gulp dependían de binarios externos (mozjpeg, etc.)
// que no se instalaban correctamente y generaban archivos corruptos.
import sharp from 'sharp';
import { globby } from 'globby';
import path from 'path';
import fs from 'fs';

const sass = gulpSass(dartSass);

function css() {
    // Compilar sass
    // Paso 1 - Identificar archivo scss
    // Paso 2 - Compilar
    // Paso 3 - Guardar el .css
    return src("./src/SCSS/app.scss")
        .pipe(sourcemaps.init())
        .pipe(sass().on('error', sass.logError))
        .pipe(postcss([autoprefixer(),cssnano()]))
        .pipe(sourcemaps.write('.'))
        .pipe(dest('./build/css'));
}

// Optimiza jpg/png con sharp y copia los svg tal cual (sharp no los procesa)
async function imagenes() {
    fs.mkdirSync('build/img', { recursive: true });

    const rasterFiles = await globby('src/img/**/*.{jpg,jpeg,png}');
    for (const file of rasterFiles) {
        const ext = path.extname(file).toLowerCase();
        const filename = path.basename(file);
        const image = sharp(file);

        if (ext === '.png') {
            await image.png({ quality: 80 }).toFile(`build/img/${filename}`);
        } else {
            await image.jpeg({ quality: 80 }).toFile(`build/img/${filename}`);
        }
    }

    // Los SVG no se optimizan con sharp, se copian directo
    const svgFiles = await globby('src/img/**/*.svg');
    for (const file of svgFiles) {
        const filename = path.basename(file);
        fs.copyFileSync(file, `build/img/${filename}`);
    }
}

// Genera versión .webp de cada jpg/png
async function versionWebp() {
    fs.mkdirSync('build/img', { recursive: true });

    const files = await globby('src/img/**/*.{jpg,jpeg,png}');
    for (const file of files) {
        const filename = path.basename(file, path.extname(file));
        await sharp(file)
            .toFormat('webp')
            .toFile(`build/img/${filename}.webp`);
    }
}

function dev() {
    watch("./src/SCSS/**/*.scss", css);
    watch("./src/img/**/*", imagenes);
}

export { css, dev, imagenes, versionWebp };

// series - inicia una tarea, y hasta que finaliza, no ejecuta la siguiente
export default series(imagenes, versionWebp, css, dev);
// parallel ejecuta todas las tareas en simultaneo
// export default parallel(css, dev)