# List_MIPS
This **MIPS** program has 4 lists, each list can carry 20 characters with their priorities<br />
For example<br />
**Character: a  Priority:2**<br />
It will print all the characters in the 4 lists sorted using quick sort according to their priorities,<br /> 
For example <br />
*priority :1 will come before priority:2*<br />
This is the structure of List in **C**<br />
```
#define MAX 20
typedef struct{
  int priority;
  char data;
}entry;

typedef struct{
  entry arr[MAX];
  int Size;
}List;
```
Function ProcessAllRequests will call function TransferListToArray 4 times each time will take one of the lists,
to transfer the 4 lists into 1 array to be able to sort and print them, and these are the 2 functions in **C** that are translted to Mips.
```
int TransferListToArray(entry arr[],int i,List *l)
{
   int j=0;
   entry e;
   while(!isempty(l))
    {
     Delete(l,j,&e);
     arr[i].data=e.data;
     arr[i].priority=e.priority;
     i++;
   }
   return i;
}
void ProcessAllRequests()
{

   int i=0;
   int j=0;

   i=TransferListToArray(arr,i,&l1);
   i=TransferListToArray(arr,i,&l2);
   i=TransferListToArray(arr,i,&l3);
   i=TransferListToArray(arr,i,&l4);

   Quicksort(arr,0,i-1);

   for(int k=0;k<i;k++)
   {
      printf("character: %c priority: %d\n",arr[k].data,arr[k].priority);
   }
}

```
Delete function will delete every element transferred from the list to the array ,to leave all the lists empty after printing all requests,<br/>
and this is the function in **C** that is translted to Mips.
```
void Delete(List *l,int p,entry *e){
  if(!isempty(l)){
    *e=l->arr[p];
    for(int i=p;i<(l->Size)-1;i++){
      l->arr[i]=l->arr[i+1];
    }
    l->Size--;
  }else{
    printf("list is empty\n");
  }
}
```
 Is empty function checks if the list is empty or not by accessing the last 4 bytes in a list and see the number of elements in the list ,return one if the list is empty otherwise return zero, <br/>this is the function in **C** that is translted to Mips.

```
int isempty(List *l){
  return l->Size==0;
}
```
Quick Sort Translated to Mips:
```
int partition(entry a[],int low,int high)
{
   int pivot=a[high].priority;
   int i=low,j;
   for(j=low;j<high;j++)
   {
      if(a[j].priority<pivot)
      {
        entry temp;
        temp=a[j];
        a[j]=a[i];
        a[i]=temp;
         i++;
       }
    }
    entry temp=a[high];
    a[high]=a[i];
    a[i]=temp;
    return i;
 }
void Quicksort(entry a[],int low,int high)
{
    if(low<high)
    {
        int pivot=partition(a,low,high);
        Quicksort(a,low,pivot-1);
        Quicksort(a,pivot+1,high);

    }
}
```


**Output of program will be like this**
>character: c priority: 1<br />
>character: b priority: 2<br />
>character: k priority: 3<br />
>character: a priority: 4<br />
>character: d priority: 5<br />

