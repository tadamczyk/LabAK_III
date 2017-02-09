//******************************//
//       TOMASZ ADAMCZYK        //
//       Nr albumu: 243217      //
//       Informatyka II ROK     //
//       Projekt3.s             //
//******************************//

// Tresc zadania:
// f(n) = { m, gdy n = 0;
//        { 1, gdy n = 1;
//        { 0, gdy n = 2;
//        { 2*f(n-1, m) + f(n-2, m) - 2*f(n-3, m), gdy n>2
// A. Argument przekazywany przez rejestr EDX, pozostale rejestry przez stos;
// B. Wynik zwracany przez rejestr EBX;
// C. Za uporzadkowanie stosu odpowiada wywolywana funkcja;
// D. Wywolywana funkcja musi zachowac wszystkie rejestry
//    (oprocz rejestru, w ktorym zwracany jest wynik).

.intel_syntax noprefix
.text
.globl main

main:
// eax - przechowuje wartosc argumentu m
// edx - przechowuje wartosc argumentu n
// ebx - przechowuje wartosc wynikowa
// ecx - rejestr wykorzystywany do obliczen
// przekazanie m przez stos
// wywolanie funkcji function
// czyszczenie stosu z wykorzystaniem esp
// wrzucenie na stos ebx - wartosci wynikowej
// wrzucenie na stos wynik etykiety msg
// wywolanie funkcji printf, czyli wypisanie wyniku
// ustawienie wskaznika stosu esp
// zerowanie rejestru eax
// zakonczenie maina

// function:
// zerowanie wynikowego rejestru ebx
// wrzucenie na stos rejestru ebp
// przypisanie do ebp wartosci esp, czyli miejsca stosu
// wrzucenie na stos eax
// wrzucenie na stos edx
// wrzucenie na stos ecx
// wczytanie zmiennej m przez stos
// sprawdzenie czy n = 0
// jesli nie skocz do f1
// jesli tak to ebx przyjmuje wartosc eax, czyli wynik rowny m
// jesli tak to skocz do final

// f1:
// sprawdzenie czy n = 1
// jesli nie skocz do f2
// jesli tak to ebx przyjmuje wartosc 1, czyli wynik rowny 1
// jesli tak to skocz do final

// f2:
// sprawdzenie czy n = 2
// jesli nie skocz do fnext
// jesli tak to ebx przyjmuje wartosc 0, czyli wynik rowny 0
// jesli tak to skocz do final

// fnext:
// wrzucenie na stos edx, czyli wartosci n
// zmniejszenie edx o 1
// wrzucenie na stos ebx, czyli zapamietanie dotychczasowego wyniku
// wrzucenie na stos eax, czyli wartosci m
// wywolanie funkcji function
//
// zdjecie ze stosu ostatniej wartosci i wpisanie do ecx, czyli stare ebx
// dodanie ebx do ebx, czyli zrobienie +2*f(n-1)
// dodanie ecx do ebx, czyli dodanie starej wartosci ebx do nowej
// zdjecie ze stosu i wpisanie do edx poczatkowej wartosci n
// wrzucenie na stos poczatkowej wartosci n
// zmniejszenie edx o 2
// wrzucenie na stos ebx, czyli zapamietanie dotychczasowego wyniku
// wrzucenie na stos eax, czyli wartosci m
// wywolanie funkcji function
//
// zdjecie ze stosu ostatniej wartosci i wpisanie do ecx, czyli stare ebx
// dodanie ecx do ebx, czyli dodanie starej wartosci ebx do nowej, czyli zrobienie +f(n-2)
// zdjecie ze stosu i wpisanie do edx poczatkowej wartosci n
// wrzucenie na stos poczatkowej wartosci n
// zmniejszenie edx o 3
// wrzucenie na stos ebx, czyli zapamietanie dotychczasowego wyniku
// wrzucenie na stos eax, czyli wartosci m
// wywolanie funkcji function
//
// zdjecie ze stosu ostatniej wartosci i wpisanie do ecx, czyli stare ebx
// odjecie ebx od ecx, czyli od dotychczasowego wyniku odejmujemy nowy, czyli zrobienie -f(n-3)
// odjecie ebx od ecx, czyli od dotychczasowego wyniku odejmujemy nowy, czyli zrobienie -f(n-3), razem -2*f(n-3)
// przeniesienie nowego wyniku z ecx do ebx
// zdjecie ze stosu ostatniej wartosci i wpisanie jej do edx, czyli przywrocenie n

// final:
// zdjecie ze stosu i wpisanie do ecx
// zdjecie ze stosu i wpisanie do edx
// zdjecie ze stosu i wpisanie do eax
// zdjecie ze stosu i wpisanie do ebp
// zakonczenie funkcji


// msg:
// komunikat do wypisu
// byte 0
