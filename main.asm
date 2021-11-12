TITLE Two's complement
 
INCLUDE Irvine32.inc
.data
 
str1 BYTE "Please Enter 4-digit Hexdecimal integar (e.g., A1B2): ", 0
str2 BYTE "Two's Complement of Hex ", 0
str3 BYTE " is ", 0
str4 BYTE "Try again? (y/n) ", 0
input BYTE 5 DUP(0)
error BYTE "Error", 0
con BYTE 0
.code
main PROC
call clrscr
 
start:
    mov edx, OFFSET str1
    call WriteString
 
    mov edx, OFFSET input
    mov ecx, SIZEOF input
    call ReadString
 
    mov ebx, OFFSET input
    call capitalize
 
    mov edx, OFFSET str2
    call WriteString
 
    mov edx, OFFSET input
    call WriteString
 
    mov edx, OFFSET str3
    call WriteString
 
    mov ebx, OFFSET input
    call string_to_digit
 
    mov ebx, OFFSET input
    call hex_validate
 
    mov ebx, OFFSET input
    call print
    call crlf
    call get_user_choice
 
capitalize:
    mov al, [ebx]       
    cmp al, 0              
    je finish          
    cmp al, 97            
    jl skip_capitalize    
    cmp al, 122             
    jg skip_capitalize     
    sub al, 32              
    mov[ebx], al           
    jmp skip_capitalize         
 
skip_capitalize:
    inc ebx                 
    jmp capitalize
 
string_to_digit:
    mov al, [ebx]
    cmp al, 0
    je finish
    cmp al, 58
    jl int_convert
    cmp al, 64
    jg char_convert
 
int_convert:
    sub al, 48
    mov[ebx], al
    jmp skip_convert
 
char_convert:
    sub al, 55
    mov[ebx], al
    jmp skip_convert
 
skip_convert:
    inc ebx
    jmp string_to_digit
 
hex_validate:
    mov al, [ebx]
    cmp al, 0
    je finish
    cmp al, 15         
    jg invalid
    jmp skip_validate
 
skip_validate:          
    inc ebx             
    jmp hex_validate    
 
invalid:
    mov edx, offset error
    call WriteString
    call crlf
    jmp get_user_choice
 
print:
    mov eax, 0
    mov ecx, 4
    L1:
        shl ax, 4
        add al, [ebx]
        inc ebx
    Loop L1
    xor ax, 0FFFFh
    inc ax
    mov ebx, 2
    call WriteHexB
    ret
 
get_user_choice:
    mov edx, offset str4
    call WriteString
    call ReadChar
    call WriteChar
    mov con, al
    call crlf
    call crlf
    cmp con, 'y'
    je start
    cmp con, 'Y'
    je start
    exit
 
finish:
    ret
 
main ENDP
END main