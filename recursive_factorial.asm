extern _printf


global _main


%define n	ebp - 4


segment .data
	format: db "factorial of %d is %d", 10, 0


segment .text
	_main:
		push ebp
		mov ebp, esp

		; init local var n
		sub esp, 4
		mov eax, dword 5
		mov [n], eax

		; calculate the factorial of n
		push dword [n]
		call _factorial
		add esp, 4

		; print the calculated factorial
		push eax
		push dword [n]
		push format
		call _printf
		add esp, 12

		mov esp, ebp
		pop ebp
		ret

	; Calculates the factorial
	_factorial:
		push ebp
		mov ebp, esp

		; temp storage for the parameter
		mov eax, [ebp + 8]

		cmp eax, dword 0
		je _stop_conditon

		; decrement the temporary variable that holds the parameter and
		; pass it to the recursive factorial call
		dec eax
		push eax
		call _factorial
		add esp, 4

		; multiply the parameter with the result of the previous 
		; factorial call
		mul dword [ebp + 8]
		jmp _stop

		; n is equal to 0
		_stop_conditon:
			mov eax, 1	; factorial of 0 is 1

		_stop:

		mov esp, ebp
		pop ebp
		ret


