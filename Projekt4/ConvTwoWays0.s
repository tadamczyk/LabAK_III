.intel_syntax noprefix
.text
.globl _start

_start:
// Program dla liczb trzycyfrowych (0-999)
// konwersja pierwszego argumentu podanego w terminalu na liczbę (Przyklad: "123" (forma znaków)==> 123 (liczba))
  mov eax, 0
// wrzucenie do ecx pierwszego argumentu
  mov ecx, [esp+8]
// wrzucenie do bl pierwszej cyfry podanego argumentu
  mov bl, byte ptr [ecx]
// odjęcie od pobranego znaku pierwszej cyfry znaku '0' ('1' == 49, '0' == 48, 49-48 = 1 --- ASCII)
  sub bl, '0'
// przeniesienie do ebx wartosc z bl, czyli 1
  movzx ebx, bl
// dodanie do eax ebx (eax = 0 + ebx = 1)
  add eax, ebx
// sprawdzenie czy jest wiecej znakow w podanym argumencie
  cmp byte ptr [ecx+1], 0
// jesli nie ma to wypad
  je conv
// wrzucenie do bl drugiej cyfry podanego argumentu
  mov bl, byte ptr [ecx+1]
// odjęcie od pobranego znaku drugiej cyfry znaku '0' ('2' == 50, '0' == 48, 50-48 = 2 --- ASCII)
  sub bl, '0'
// przeniesienie do ebx wartosc z bl, czyli 2
  movzx ebx, bl
// pomnozenie dotychczasowego eax przez 10
  imul eax, 10
// dodanie do eax ebx (eax = 10 + ebx = 12)
  add eax, ebx
// sprawdzenie czy jest wiecej znakow w podanym argumencie
  cmp byte ptr [ecx+2], 0
// jesli nie ma to wypad
  je conv
// wrzucenie do bl drugiej cyfry podanego argumentu
  mov bl, byte ptr [ecx+2]
// odjęcie od pobranego znaku trzeciej cyfry znaku '0' ('3' == 51, '0' == 48, 51-48 = 3 --- ASCII)
  sub bl, '0'
// przeniesienie do ebx wartosc z bl, czyli 3
  movzx ebx, bl
// pomnozenie dotychczasowego eax przez 10
  imul eax, 10
// dodanie do eax ebx (eax = 120 + ebx = 123)
  add eax, ebx
// liczba znajduje sie w eax; teraz mozna cos z nia zrobic, np. pomnozyc przez 2, dodac 115 itd.

conv:
// ecx jest podstawa mnozenia
  mov ecx, 10
// ebx jest licznikiem znakow
  xor ebx, ebx

divide:
// zerowanie edx, ktory jest reszta z dzielenia
  xor edx, edx
// dzielenie eax przez ecx, czyli liczby przez 10 (123/10: eax = 12, edx = 3; 12/10: eax = 1, edx = 2, 1/10: eax = 0, edx = 1)
  div ecx
// wrzucenie edx na stos (najpierw 3, potem 2, potem 1)
  push edx
// zwiekszenie licznika wystapien
  inc ebx
// sprawdzenie czy eax cos jeszcze ma
  test eax, eax
// jesli nie ma to wypad
  jnz divide

next_digit:
// sciagam ze stosu "szczytowa" rzecz, czyli ostatnia wrzucona liczbe i wrzucam do eax (eax == 1)
  pop eax
// doanie do eax '0' (eax = 1 + '0' = 1 + 48 = 49)
  add eax, '0'
// wrzucenie do pierwszego znaku bufora wypisu eax (49 == '1')
  mov [sum], eax
// zmniejszenie licznika o 1
  dec ebx
// sprawdzenie czy licznik == 0
  cmp ebx, 0
// jesli tak to wypad
  je final
// sciagam ze stosu kolejna liczbe i wrzucam do eax (eax == 2)
  pop eax
// doanie do eax '0' (eax = 2 + '0' = 2 + 48 = 50)
  add eax, '0'
// wrzucenie do drugiego znaku bufora wypisu eax (50 == '2')
  mov [sum+1], eax
// zmniejszenie licznika o 1
  dec ebx
// sprawdzenie czy licznik == 0
  cmp ebx, 0
// jesli tak to wypad
  je final
// sciagam ze stosu kolejna liczbe i wrzucam do eax (eax == 3)
  pop eax
// doanie do eax '0' (eax = 3 + '0' = 3 + 48 = 51)
  add eax, '0'
// wrzucenie do trzeciego znaku bufora wypisu eax (51 == '3')
  mov [sum+2], eax
// zmniejszenie licznika o 1
  dec ebx
// sprawdzenie czy licznik == 0
  cmp ebx, 0
// jesli tak to wypad
  je final

final:
// edx to dlugosc napisu
  mov  edx, 3
// ecx to bufor wypisu
  mov  ecx, offset sum
// ebx tak ma byc i tyle
  mov  ebx, 1
// eax tak ma byc i tyle
  mov  eax, 4
  int  0x80
  mov  edx, 1
  mov  ecx, offset msg
  mov  ebx, 1
  mov  eax, 4
  int  0x80
  mov  eax, 1
  int  0x80

.data
msg: .ascii "\n"
sum: .byte 0, 0, 0, 0
