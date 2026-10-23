<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>Yuks - Apps & Sites</title>
    <style>
        /* Звичайні стилі твого сайту */
        body {
            background-color: #0d1117;
            color: #c9d1d9;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            margin: 0;
            padding: 40px;
            transition: all 0.3s ease;
        }

        h1 { color: #58a6ff; }

        /* Секретний режим (Термінал / Hacker mode) */
        body.hacker-mode {
            background-color: #000000 !important;
            color: #00ff66 !important;
            font-family: "Courier New", Courier, monospace !important;
        }
        body.hacker-mode h1 {
            color: #00ff66 !important;
            text-shadow: 0 0 10px #00ff66;
        }

        /* Canvas для дощу */
        #matrix-canvas {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 9999;
            pointer-events: none; /* щоб можна було клікати крізь нього */
        }
    </style>
</head>
<body>

    <canvas id="matrix-canvas"></canvas>

    <div id="content">
        <h1>Yuks</h1>
        <p>Сайт із програмами та сайтами. Створено з кавою та вайбом.</p>
        <p><em>Підказка для своїх: спробуй ввести легендарну комбінацію стрілочок і кнопок... (Konami Code)</em></p>
    </div>

    <script>
        // 1. КОНАМІ-КОД ЛОГІКА
        const konamiCode = ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 'b', 'a'];
        let kujIndex = 0;

        document.addEventListener('keydown', (e) => {
            // Перевіряємо клавішу (регістр не важливий для 'b' та 'a')
            if (e.key === konamiCode[kujIndex] || e.key.toLowerCase() === konamiCode[kujIndex]) {
                kujIndex++;
                if (kujIndex === konamiCode.length) {
                    activateHackerVibe();
                    kujIndex = 0;
                }
            } else {
                kujIndex = 0; // скидаємо, якщо помилився
            }
        });

        // 2. АКТИВАЦІЯ СЕКРЕТНОГО РЕЖИМУ ТА ДОЩУ
        function activateHackerVibe() {
            // Увімкнути хакерську тему
            document.body.classList.toggle('hacker-mode');
            
            // Запустити дощ
            const canvas = document.getElementById('matrix-canvas');
            const ctx = canvas.getContext('2d');

            if (canvas.style.display === 'block') {
                canvas.style.display = 'none'; // вимкнути, якщо вже працювало
                return;
            }

            canvas.style.display = 'block';
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;

            // Букви для дощу (можна додати слова 'Yuks', нулі, одиниці)
            const letters = 'Y U K S 0 1 0 1 < / > { } $ # _';
            const fontSize = 16;
            const columns = canvas.width / fontSize;
            const drops = [];

            for (let i = 0; i < columns; i++) {
                drops[i] = 1;
            }

            function drawMatrix() {
                ctx.fillStyle = 'rgba(0, 0, 0, 0.05)';
                ctx.fillRect(0, 0, canvas.width, canvas.height);

                ctx.fillStyle = '#00ff66';
                ctx.font = fontSize + 'px monospace';

                for (let i = 0; i < drops.length; i++) {
                    const text = letters.charAt(Math.floor(Math.random() * letters.length));
                    ctx.fillText(text, i * fontSize, drops[i] * fontSize);

                    if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) {
                        drops[i] = 0;
                    }
                    drops[i]++;
                }
            }

            // Інтервал анімації дощу
            if (window.matrixInterval) clearInterval(window.matrixInterval);
            window.matrixInterval = setInterval(drawMatrix, 33);

            console.log("%c Yuks Dev Mode Activated! 😎", "background: #222; color: #00ff66; padding: 5px; font-size: 14px;");
        }
    </script>
</body>
</html>