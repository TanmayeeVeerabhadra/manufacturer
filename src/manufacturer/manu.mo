import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Array "mo:base/Array";
actor manufacturer{
  stable var finalProducts:[(Text,Nat)]=[];
  type List<Text> = ?(Text, List<Text>);
  var manufacturers :List<Text> = List.nil();
  //Debug.print(debug_show("hello world"));
  //Debug.print(debug_show("hello awesome"));
  var products=HashMap.HashMap<Text,Nat>(1,Text.equal,Text.hash);
  Debug.print(debug_show(Iter.toArray(products.entries())));
  public func addProduct(newproduct:Text,id:Nat,urId:Text) :async Text{
    if(products.get(newproduct)==null){
      products.put(newproduct,id);
      manufacturers := List.push(urId,manufacturers);
      return "product added successfully";
    }else{
      return "product already exists";
    };

  };
  Debug.print(debug_show(finalProducts));
  //adds the entries of hashmap to the stable array before every upgrade
  public func seller(manufacturerId:Text,product:Text,id:Nat):async Text{
    if(products.get(product)==null){
      return "sorry product unavailable";
    };
    let removedProduct :Text=switch(products.remove(product)){
      case null "";
      case (?result) "Product removed successfully";
    };
    return "success";
  };

  system func preupgrade(){
    finalProducts:=Iter.toArray(products.entries());
  };
  //after the upgrade the unstable ledger(Hashmap) collects the elements of the stable array
  system func postupgrade(){
    products:=HashMap.fromIter<Text,Nat>(finalProducts.vals(),1,Text.equal,Text.hash);
  };
}
