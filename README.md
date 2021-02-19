# List_MIPS
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
```
int isempty(List *l){
  return l->Size==0;
}
```
```
typedef struct{
  int priority;
  char data;
}entry;

typedef struct{
  entry arr[MAX];
  int Size;
}List;
```
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
```
```
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
```
```
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
Output
character: c priority: 1
character: b priority: 2
character: k priority: 3
character: a priority: 4
character: d priority: 5

