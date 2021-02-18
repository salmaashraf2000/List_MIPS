.data 

char: .asciiz "character: "
priority: .asciiz "priority: "
newline: .asciiz "\n"

#Each List will contain 20 character and their priorities 
#8 byte for each element (element conain priority(int) 4 bytes)
#and character 4 bytes) 
.align 2  # asking for 2^2=4 byte alignment
list1: .space 164 # list contain chars,their priorities and size of list
                  #(priority,char--priority,char....),priority of first char in (0),char in 4 ...etc and size of list in 160
.align 2  # asking for 2^2=4 byte alignment
list2: .space 164 # list contain chars,their priorities and size of list
                  #(priority,char--priority,char....),priority of first char in (0),char in 4 ...etc and size of list in 160
.align 2  # asking for 2^2=4 byte alignment
list3: .space 164  # list contain chars,their priorities and size of list
                  #(priority,char--priority,char....),priority of first char in (0),char in 4 ...etc and size of list in 160
.align 2  # asking for 2^2=4 byte alignment
list4: .space 164  # list contain chars,their priorities and size of list
                  #(priority,char--priority,char....),priority of first char in (0),char in 4 ...etc and size of list in 160
.align 2  # asking for 2^2=4 byte alignment
arr: .space 640 # array for processing all requests                
                  
.align 2  # asking for 2^2=4 byte alignment
entry: .space 8 # contain the data and its priority                  

.text 
.globl main

main:

    la $t1,list1                    #load address of list 1
    la $t2,list2                    #load address of list 2
    la $t3,list3                    #load address of list 3
    la $t4,list4                    #load address of list 4
    
    addi $t8,$zero,2                #$t8=2 (to set size of list)
    sw $t8,160($t1)                 #store in 160 of address of list1($t1) the size of list ($t8)

    addi $t8,$zero,2                #$t8=2 (to set size of list)
    sw $t8,160($t2)                 #store in 160 of address of list2($t2) the size of list ($t8)
    
    addi $t8,$zero,1                #$t8=1 (to set size of list)
    sw $t8,160($t3)                 #store in 160 of address of list3($t3) the size of list ($t8)
    
    addi $t8,$zero,0                #$t8=0 (to set size of list)
    sw $t8,160($t4)                 #store in 160 of address of list4($t4) the size of list ($t8)
    
    
    #store character and its priority in list(store priority first then list)
    #for example address of list is in $t1 so 0($t1) contain priority 4($t1) contain its character
    # 8($t1) new priority 12($t1) new character .........etc
    
    addi $t5,$zero,4                #put priority in $t5 $t5=4
    sw $t5,0($t1)                   #store priority in list 1
    li $t6,'a'                      #put character in $t6 
    sw $t6,4($t1)                   #store character in list 1
    
    addi $t5,$zero,1                #put priority in $t5 $t5=1
    sw $t5,8($t1)                   #store priority in list 1
    li $t6,'c'                      #put character in $t6 
    sw $t6,12($t1)                  #store character in list 1
    
    addi $t5,$zero,2                #put priority in $t5 $t5=2
    sw $t5,0($t2)                   #store priority in list 2
    li $t6,'b'                      #put character in $t6 
    sw $t6,4($t2)                   #store character in list 2
    
    addi $t5,$zero,5                #put priority in $t5 $t5=5
    sw $t5,8($t2)                   #store priority in list 2
    li $t6,'d'                      #put character in $t6 
    sw $t6,12($t2)                  #store character in list 2
    
    addi $t5,$zero,3                #put priority in $t5 $t5=3
    sw $t5,0($t3)                   #store priority in list 3
    li $t6,'k'                      #put character in $t6 
    sw $t6,4($t3)                   #store character in list 3
    
    #list 4 is empty did not insert anything in it
   
   jal ProcessAllRequests           #call ProcessAllRequests function
   li $v0, 10                       # Terminate program run and
   syscall                          # Exit


    

    
swap:				#swap method

	addi $sp, $sp, -12	# Make stack room for three

	sw $a0, 0($sp)		# Store a0   //arr
	sw $a1, 4($sp)		# Store a1   //i
	sw $a2, 8($sp)		# store a2   //j

	sll $t1, $a1, 3 	#t1 = 8i
	add $t1, $a0, $t1	#t1 = arr + 8i
	lw $s3, 0($t1)		#s3  t = array[i].priority
	lw $s5, 4($t1)         #s5   t = array[i].data    

	sll $t2, $a2, 3 	#t2 = 8j
	add $t2, $a0, $t2	#t2 = arr + 8j
	lw $s4, 0($t2)		#s4 = arr[j]
	lw $s6, 4($t2)         #s5   t = array[j].data  

	sw $s4, 0($t1)		#arr[i].priority = arr[j].priority
	sw $s3, 0($t2)		#arr[j].priority = t
	
	sw $s5, 4($t2)		#arr[j].data = t #
	sw $s6, 4($t1)		#arr[i].data = arr[j].data 

        
	addi $sp, $sp, 12	#Restoring the stack size
	jr $ra			#jump back to the caller
	


partition: 			#partition method

	addi $sp, $sp, -16	#Make room for 5

	sw $a0, 0($sp)		#store a0
	sw $a1, 4($sp)		#store a1
	sw $a2, 8($sp)		#store a2
	sw $ra, 12($sp)		#store return address
	
	move $s1, $a1		#s1 = low
	move $s2, $a2		#s2 = high

	sll $t1, $s2, 3		# t1 = 8*high
	add $t1, $a0, $t1	# t1 = arr + 8*high
	lw $t2, 0($t1)		# t2 = arr[high] //pivot

	addi $t3, $s1, 0 	#t3, i=low 
	move $t4, $s1		#t4, j=low
	addi $t5, $s2, 0	#t5 = high 
         
	forloop: 
		
                beq $t4,$t5,endfor     #if j==high branch to endfor
                mul $t1,$t4,8          #multiply array index by 8
		add $t1, $t1, $a0	#t1 = arr + 8j
		lw $t7, 0($t1)		#t7 = arr[j]
		

		slt $t8, $t2, $t7	#t8 = 1 if pivot < arr[j], 0 if arr[j]<=pivot
		beq $t2,$t7,endfif     # if pivot = arr[j] branch to endfif noooooooooo
		bne $t8, $zero, endfif	#if t8=1 then branch to endfif
		

		move $a1, $t3		#a1 = i
		move $a2, $t4		#a2 = j
		addi $t3, $t3, 1	#i=i+1 
		jal swap		#swap(arr, i, j)
		
		addi $t4, $t4, 1	#j++
		j forloop

	    endfif:
		addi $t4, $t4, 1	#j++
		j forloop		#junp back to forloop

	endfor:
		addi $a1, $t3, 0		#a1 = i
		move $a2, $s2			#a2 = high  
		add $v0, $zero, $a1		#v0 = i return (i );
		jal swap			#swap(arr, i , high);

		lw $ra, 12($sp)			#return address
		addi $sp, $sp, 16		#restore the stack
		jr $ra				#junp back to the caller

quicksort:				#quicksort function

	addi $sp, $sp, -16		# Make room for 4

	sw $a0, 0($sp)			# a0
	sw $a1, 4($sp)			# low
	sw $a2, 8($sp)			# high
	sw $ra, 12($sp)			# return address

	move $t0, $a2			#saving high in t0

	slt $t1, $a1, $t0		# t1=1 if low < high, else 0
	beq $t1, $zero, endif		# if low >= high, endif

	jal partition			# call partition 
	move $s0, $v0			# pivot, s0= v0

	lw $a1, 4($sp)			#a1 = low
	addi $a2, $s0, -1		#a2 = pi -1
	jal quicksort			#call quicksort

	addi $a1, $s0, 1		#a1 = pi + 1
	lw $a2, 8($sp)			#a2 = high
	jal quicksort			#call quicksort

 endif:

 	lw $a0, 0($sp)			#restore a0
 	lw $a1, 4($sp)			#restore a1
 	lw $a2, 8($sp)			#restore a2
 	lw $ra, 12($sp)			#restore return address
 	addi $sp, $sp, 16		#restore the stack
 	jr $ra				#return to caller
 	

#take address of arr , index(that we will start from) and address of a list 	 	
#this function is called 4 times in ProcessAllRequests function
#every time another list will be sent
#to get all data in the 4 lists to be in one array 	
TransferListToArray:

     addi $sp,$sp,-4                  #store return address
     addi $s0,$ra,0
     sw $s0,0($sp)
    
    addi $s1,$a0,0                    #$a0 contains address of arr
    addi $s2,$a1,0	               #$t2=i
    addi $s3,$a2,0                    #$a2 contains address of List
    
    
    While:
         addi $a0, $s3, 0                  #$a0 contains address of list
         jal isempty
         beq $v1, 1, endWhile
          #delete function parameters
         addi $a0, $s3, 0                  #$a0 contains address of list
         addi $a1,$zero,0	            #$t2=0 //j
         la $a2,entry                      #load address of entry(to return the item that will be deleted) in $a2
        
         jal Delete                        #call delete function
         mul $t4,$s2,8                     #multiply array index by 8
         add $t5,$s1,$t4                   #add array index to base address
         la $t6,entry                      #load address of entry
         lw $t7,0($t6)                     #load priority of item (entry)
         lw $t8,4($t6)                     #load char of item (entry)
         sw $t7,0($t5)                     #store priority of item in arr
                                           #arr[i].data=e.data
         sw $t8,4($t5)                     #store data of item in arr
                                           #arr[i].priority=e.priority
         addi $s2,$s2,1                    #i=i+1                                  
         j While
    endWhile:    
        
        addi $v1,$s2,0                #put $t4(i) in $v1 to return i
        lw $s0,0($sp)                 #load return address
        add $sp,$sp,4  
        addi $ra,$s0,0
        jr $ra 
   
             
    
#take address of List and check if it is empty
#set $v1 to be equal 1 if list is empty otherwise $v1=0 
isempty:
 
    addi $v1,$zero,0                  #set $v1=0
    addi,$t0,$zero,0                  #set $t0=0
    lw $t0,160($a0)                   #load size of list in $t0
    addi $v1,$zero,0                  #$v1=0
    beq $t0,$zero,SetEqualOne         #if $t0(size of list)==0, then $v1=1
    
    j return
    SetEqualOne:
          addi $v1,$v1,1             #set $v1=1
          j return
    return:      
       jr $ra    

                 
#this function take an address of a List , position to be deleted from list
#and address(that we will put in it the character and its priority that will be deleted)                                                   
Delete:
     
      addi $sp,$sp,-4                #make room in stack
      sw $ra,0($sp)                  #store return address
     
     jal isempty                     #call isempty
     bne $v1,$zero,Exit              #if $v1!=0 (list empty) then exit
     addi $t0,$a0,0                  #set address of list in $t0
     addi $t1,$a1,0                  #set index of char to be deleted in $t1
     addi $t2,$a2,0                  #set address of char and its priority in $t2
     lw $t4,160($a0)                 #load size of list in $t0
     addi $t5,$t4,-1                 #decrement $t4
     
     la $t4,($t4)
     
     #load the item to be deleted in entry
     mul $t3,$t1,8                #multiply array index by 8
     add $t6,$t0,$t3              #add list index to base address
     lw $t7,0($t6)                #load priority of item to be deleted
     lw $t8,4($t6)               #load char of item to be deleted
     sw $t7,0($t2)               #store priority of item to be deleted
     sw $t8,4($t2)               #store data of item to be deleted
     
     
     For:
        beq $t1,$t5,Exit             #if index== size of list branch to Exit
        
        mul $t3,$t1,8                #multiply array index by 8
        add $t6,$t0,$t3              #add array index to base address
        lw $t7,8($t6)                #load priority of list[i+1]
        lw $t8,12($t6)               #load char of list[i+1]
        sw $t7,0($t6)                #list[i].priority=list[i+1].priority
        sw $t8,4($t6)                #list[i].data=list[i+1].data 
        addi $t1, $t1, 1             # increment i (counter)
        
        j For
     Exit:
       
         addi $t4,$t4,-1             #decreament size of list
         sw $t4,160($a0)             #store value of $t0 to this memory address
                                     #store the new size of the list    
         lw $ra,0($sp)               #load return address
         add $sp,$sp,4                                                                              
         jr $ra
     
                                                         
#this Function print all the data that were in the 4 lists         
ProcessAllRequests:

     addi $sp,$sp,-4                   #make room in stack
     addi $s5,$ra,0                    #put return address in $s5
     sw $s5,0($sp)                     #store return address
     la $t0, arr                       # Moves the address of array into register $t0.
     la $t3,list1                      #load address of List1 in $t3
     addi $a0, $t0, 0                  #$a0 contains address of arr
     addi $a1,$zero,0	                #i=0
     addi $a2, $t3, 0                  #$a2 contains address of List1
      
     jal  TransferListToArray           #call the function
     
     #li $v0,1                          #load the return from the function
     la $t0, arr                       # Moves the address of array into register $t0.
     addi $a0, $t0, 0                  #$a0 contains address of arr
     addi $a1,$v1,0                 	#put return integer in $a1
     
     la $t3,list2                      #load address of List2 in $t3
     addi $a2, $t3, 0                  #$a2 contains address of List2
  
     jal  TransferListToArray
     
     li $v0,1                          #load the return from the function
     la $t0, arr                       # Moves the address of array into register $t0.
     addi $a0, $t0, 0                  #$a0 contains address of arr
     addi $a1,$v1,0                 	#put return integer in $a1
     
      la $t3,list3                     #load address of List2 in $t3
     addi $a2, $t3, 0                  #$a2 contains address of List3
     
     jal TransferListToArray
     
     li $v0,1                          #load the return from the function
     la $t0, arr                       # Moves the address of array into register $t0.
     addi $a0, $t0, 0                  #$a0 contains address of arr
     addi $a1,$v1,0                 	#put return integer in $a1
     
     la $t3,list4                     #load address of List2 in $t3
     addi $a2, $t3, 0                  #$a2 contains address of List4
     
     jal TransferListToArray
     
     li $v0,1                          #load the return from the function
     addi $a1,$v1,0                 	#put return integer in $a1
     addi $s7,$v1,0                 	#put return integer in $s7
     addi $t3,$a1,-1                   #$t3=i-1
     addi $t1,$a1,0                    #put $a1(i) in $t1 
      
     la $t0, arr                     # Moves the address of array into register $t0.
     addi $a0, $t0, 0                # Set argument 1 to the array.
     addi $a1, $zero, 0              # Set argument 2 to (low = 0)
     addi $a2, $t3, 0                # Set argument 3 to (high = i-1, last index in array)
      
     jal quicksort
     addi $t2, $zero, 0                #k=0
     
     la $t0,arr                      #load address of arr in $t0
     
     for:
        beq  $t2, $s7, endFor         #if k==i jump to endfor
        
        li $v0, 4                     #print string
        la $a0, char                  # load address of string to be printed into $a0
        syscall
        
      
        mul $t3,$t2,8                #multiply array index by 8
        add $t3,$t3,$t0              #$t3=4j*arr
        lw $t4,0($t3)                #$t4=arr[k].priority
        
       
        lw $t5,4($t3)                #$t5=arr[k].data
        
        
        li $v0, 11                    #print char 
        la $a0,($t5)                 # load address of string to be printed into $a0
        syscall
        

        li $a0, 32                   # print space, 32 is ASCII code for space
        li $v0, 11  
        syscall
       
        li $v0, 4                     #print string
        la $a0, priority              # load address of string to be printed into $a0
        syscall
        
        li $v0, 1                     #print priority of char
        la $a0,($t4)                  #load address of int to be printed into $a0
        syscall
        
        li $v0, 4                     #print newline
        la $a0, newline       
        syscall
         
        addi    $t2, $t2, 1          #increment k (counter)
        j for
     
     endFor:
        lw $s5,0($sp)                #load return address
        add $sp,$sp,4  
        addi $ra,$s5,0
        jr $ra
     
       
        
