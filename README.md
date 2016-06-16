# fpga_msu
Репозиторий учебного курса "Проектирование аппаратных схем ПЛИС средствами языка VHDL"


# README #

Добро пожаловать в репозиторий курса "Использование ПЛИС для высокопроизводительных вычислений"

Данный курс читается на втором курсе Физического Факультета МГУ как альтернативный курс по программированию. Работа ведется на FPGA 7 серии фирмы Xilinx.

В первой части курса даются базовые знания о ПЛИС и среде проектирования Vivado, изучается язык проектирования аппаратуры VHDL. Во второй части курса изучается высокоуровневый подход к проектирования вычислительных аппаратных ядер на языке Си в среде Vivado HLS.

В данный момент ведется работа над первой частью курса.

## Программа курса
*****
### Тема 1. Введение. Схемотехника комбинационных устройств.
*История развития интегральных схем (от транзистора до ПЛИС). Классификация современных ИС по методу соединения элементов. Общая архитектура ПЛИС. Конфигурационная память и возможность реконфигурации. Обзор семейства ПЛИС фирмы Xilinx. Применение ПЛИС в современном мире. Логические элементы в логике КМОП. Тристабильные элементы. Простые комбинационные элементы.*
*****
### Тема 2. Введение в VHDL.
*Введение в VHDL. Синтаксис и параллельная семантика. Объекты и конструкции. Типы данных. Логические и арифметические операторы языка. Синтезируемое подмножество языка VHDL и конструкции для моделирования. Создание верификационных testbenches.*

**Практика в системе Vivado:**

*   Создание проекта GUI с нуля
*   Пример 4х битного сумматора
*   Оператор For generate
*   Реализация сумматора на плате Artix-7
*   Введение в моделирование


*****
### Тема 3. Описание комбинационных устройств на VHDL.
*«Последовательные» и «параллельные» операторы. Комбинационные логические элементы и их описание на языке VHDL. Операторы выборочного и условного назначения сигналов. Оператор процесса. Запуск процесса и список чувствительности. Операторы IF и CASE. Правила кодирования комбинационных логических устройств на VHDL.*

**Практика в системе Vivado:**

*   Коммутатор-переключатель 2-на-2
*   Конвертер-генератор кода Грея

*****
### Тема 4. Схемотехника последовательных устройств и их описание на VHDL
*Понятие триггера. Статическая и динамическая синхронизация. Сложные последовательные элементы: регистры, счетчики, сдвиговые регистры. Описание последовательных элементов на VHDL. Принцип построения синхронных схем.*

**Практика в системе Vivado:**

*   Моделирование и синтез последовательно соединенных  триггеров. Знакомство со средством Vivado Schematic View.
*   Детектор переднего фронта сигнала (моделирование)
*   Демонстрация работы счетчика и сдвигового регистра (моделирование).
*   Проект мигающие лампочки (в железе)
*   Схема подавления дребезга (в железе). Знакомство со средством отладки реальных проектов – Chipscope.

*****
### Тема 5. Архитектура FPGA.
*Архитектура ПЛИС – углубленно. Фабрика логики. Структура конфигурационного логического блока и блоков ввода/вывода. Общие трассировочные ресурсы, трассировочные ресурсы для сигналов синхронизации, генераторы частоты, DSP блоки, блочная и  распределенная память. Этапы разработки проекта ПЛИС в системе Vivado. Анализ схемы после синтеза, после имплементации. Конфигурационная память и способы загрузки конфигурационных данных.*

**Практика в системе Vivado:**

*   Конвейерное вычисление y = a*x^4 + b*x^2 +  c*x + d. Изменяем частоту с помощью IP Clock Manager. На этом примере разбираем архитектуру: CLB, IBUF, OBUF, IBUFG, DSP, MMCM. Только моделирование.
*****