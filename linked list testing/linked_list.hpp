#ifndef linked_list_hpp
#define linked_list_hpp

typedef struct item{
int value;
struct item *next;
} item_t;

item_t* find(const int x, item_t* head){
while (head->value != x){
head = head->next;
if (head == NULL) break;
return head;
}

#endif