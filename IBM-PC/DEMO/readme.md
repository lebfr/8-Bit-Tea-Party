﻿ Общий файл описания и помощи, пока не понятно, стоит-ли его держать отдельно,
или всё таки всё описание просто добавить в начало самого исходного файла и
других библиотек. Ограничений на обьем всё равно почти нет. ;)

 Разделы:

 1. Общее описание, платформа и структура проекта
 2. Сборка и минимальный набор инструментов
 3. План разработки и активные задачи
 5. Краткая история изменений

 Раздел 1. Общее описание, платформа и структура проекта

 Демка для изучения ассемблера и архитектуры процессора Intel 8086/87.
 Несколько анимированных эффектов, сколько успеем и что сможем. :)
 Дата старта: 01.06.2021.
 Дата выхода проекта: 31.12.2021 ну или раньше, как будет удобней.

 Платформа: ДОС-совместимая от условной версии 5.0, реальный режим адресации.
 Процессор: только 8086(88) и математический сопроцессор 8087.
 Основная память: 64Кб для кода и стека(модель минимальная). Остальные данные
 желательно уложить в 512Кб. Для запуска на "тяжелых" ДОС конфигурациях.
 Расширенная память: через драйвер XMS, не более 16Мб(не защищенный режим).
 Графический адаптер: IBM VGA, 256Кб, 6 бит на цвет, палитра 2^18 цветов,
 графический Х-режим, 320x240x8бит на цвет по таблице.
 Звуковая плата: Adlib/SBPro(OPL2/OPL3), FM - частотная модуляция.
 Формат файла: .COM, 64Kb, использовать функции ДОС-а для запроса памяти.


 Раздел 2. Сборка и минимальный набор инструментов


 Файлы ассемблирования не вошли в репозиторий, поэтому для примера.

 assemble.bat:

rm demo.com
C:\BITSCODE\NASM\nasm.exe demo.asm -o demo.com -f bin -O0 -w+ptr
demo.com

 Комментарии по строкам.
 1. rm - удалить предыдущий исполняемый файл, если он был;
 2. C:\... - ассемблирование исходного файла ассемблером NASM, но возможно
использование любого другого ассемблера на уровне совместимости с MASM первых
версий: MASM, TASM, NASM, FASM и других.
 3. demo.com - запуск исполняемого файла, если не требуется, то можно добавить
директиву rem в начало строки.

 Директивы ассемблера в коммандной строке:

 "demo.asm" - исходный файл для ассемблирования;
 "-o demo.com" - создание обьектного файла и его имя;
 "-f bin" - простой бинарный формат без участия линковки;
 "-O0" - отключение всех оптимизаций, включая сегментные регистры(см.док);
 "-w+ptr" - предупреждения при использовании ptr, для совместимости.

 Раздел 4. Общие рекомендации для команды


 Раздел 3. План разработки

 3.1. Основные задачи для решения в порядке приоритета и если назначен:

 - работа с графикой на уровне железа;
 - установка видеорежима 320*240*256;
 - установка и настройка палитры DAC;
 - установка пикселя по координатам;
 - правление страницами памяти и лучом ЭЛТ;
 - очистка экрана или заполнения отображаемой страницы;

 - оформить струтуру файлов, директорий и пожеланий разработки;
 - настройки и параметры различных инструментов, занести прямо в этот файл;

 - добавить описания в директории или отдельно, или оставить в этом файле;

 - базовые функции для работы с музыкой на железе;


 3.2. Дополнительные задачи, которые возможно уже применим в будущем:

 - по ходу движения;

 3.3. Выполненные основные задачи:

 -

 3.4. Выполненные дополнительные задачи:

 -


 Раздел 5. Краткая история изменений


 04.09.2021
 28.08.2021 Настройка DAC адаптера, загрузка битового файла изображения и
            настройка палитры через БИОС.
 07.08.2021 Установка видеорежима и начало разработки графической библиотеки.
 27.06.2021(поправить) Процедуры умножения и набросок библиотек.
 01.06.2021 Условный старт проекта и выбор платформы.