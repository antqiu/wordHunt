class BoxList {
   Box start, back;
   
   BoxList() {
    start=null;
    //start.next=null;
   }
  
   void append(Box current) {
     Box currentBack=back;
     
     if (start==null) {
       start=current;
       back=current;
     }
     
     if (start==back) {
       start.next=current;
       back=current;
     }
     
     if (start!=null && current!=start) {
       currentBack.next=current;
       back=current;
     }
   }
   
   void reset() {
     start=null;
   }
  
}
