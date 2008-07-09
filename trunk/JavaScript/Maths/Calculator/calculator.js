/*var errors=[];
var tests = [
    "12 + 5 - 3", [12,'+',5,'-',3], 14
    "4*(2-3)",[4,'*','(',2,'-',3,')'],-4
];
for(i=0,end=(tests.length/3);i<end;i++){
    tokens = tokenize(tests[(i*3)]);
    answer = calculate(tokens);
    if(tokens != tests[(i*3)+1]){
        errors.push("Tokens for test "+i+" is wrong: "+tokens);
    }
    if(answer != tests[(i*3)+2]){
        errors.push("Answer for test "+i+" is wrong: "+answer);
    }
}
*/


function ltrim(str, chars) {
    if(str) return str.replace(/^\s*/,"");
    else return "";
}

/**
* returns a token array
* Throws parse error if unexpected symbol appears
*/
function tokenize(str,orig){
    if(typeof orig=='undefined')var orig=str;
    
    var expect = /^(\d+)|^[-+*\()a-z^=]/;
    var tokens=[]; // make token array if none exist
    
    // trim whitespaces first
    str = ltrim(str);
    // then find expected characters
    var res = str.match(expect);
//alert(res[0]);
//if(res&&res[0])document.write(str+"; "+res[0]+"\n");
    if(res && res[0]){
        tokens.push(res[0]);
        if(str.length > res[0].length){
            str = str.substring(res[0].length);
            tokens.push(tokenize(str,orig));
        } // todo: else, quit function and return
    } else {
        //throw new Error("Parse error"+str.length);
        errorat = orig.length-str.length;
        throw new Error("Parse error at position "+errorat+" in string \""+orig+"\"");
        // TODO: e=new Error;e.line=errorat; then throw it.
    }
    
    return tokens;
}


/*
need to find some way to recognize where we can simplify

12+5 for instance. or all num operator num.
we can sort everything to start with

12-4 is sum(+12 + -4) really

1. divide on equality sign, if any
2. make remove all + and - operators and make values instead
   such as "12-4" into [12,-4] 
   2.1 in parenthesis you do the same, "12-4-(5*2)" is
       [12,-4,[-1,*,5,*,2]]


1. take first token, look at next. 
2. if next requires more, look at next.
3. when done, simplify.
*/


/**
* makes a tree of the calculation, so
* x=12+5-4+(5a^2+1)
* is
* 
x
=
+12
+5
-4
+
  5
  *
    a
    ^
    2
+1

left side of equality
right side of equality
(if left side is empty, assume single unknown)

sort values, simplest first
  meaning + and -
  then comes * and /
  then comes ^ and (square root? maybe ¤? or 
  rather ^(1/2) is actually correct)
*/
function structure(t){
    var s=[];
    
    for(i=0,end=t.length;i<end;i++){
        if( typeof t[i]=='number' ){
            s.push(t[i]);
        } else if( t[i]=='-' ){
            // then, if we have a number add negative number
            if(typeof t[i+1]=='number'){
                s.push(t[i+1]);
                i++;
            } else if(t[i+1]=='('){
                // context, add until ')'
            }
            // or if it is a group, add -1 times the group
        }
    }
}

/**
* Attempts to simplify the solution.
* Note, if you try to do simplify(x)
* and get the same result as last, you're done.
* return token [2,'/',3] for instance
*
* @param array   A token to simplify
*/
function struct(token){
    var add=[];
    var t = token.slice();
    var positive=true; // positive or negative numbers
    
    // context, expecting group
    this.moo = function(){
        for(f in t){
            add.push(t[f]);
        }
    }
    
    this.toString = function(){
        //this.c_group(); 
        //document.write(s);
        return '+{'+add+'}';
    }
    
    this.moo();
}
/*function simplify(to){
    //var s=[]; // simplified token
    this.add=[];
    this.sub=[];
    var t = to.slice();
    
    // context, expecting group
    this.c_group = function(){
        var i = t.shift(); // get first index 
        if(i=='+')i=t.shift(); // already assume +, so ignore
        
        if(  i == "-" ){
            // what now, if next is number then push negative number
            // if next is parenthesis, then assume number is 1 and goto new group
            this.c_negatives();
        }
        
        if(typeof i=='string'){
            if(i.match(/^\d+/)){
                this.add.push(i);
                this.c_group();
            }
        } else if(typeof i=='array'){
            // todo
            
        }
    }
    
    this.c_negatives = function(){
        var i = t.shift();
        if(typeof i=='string'){
            if(i.match(/^\d+/)){
                this.sub.push(i);
                this.c_
            }
        } else if(i=='('){
            this.sub.push(1);
            c_group();
        }
    }
    
    this.toString=function(){
        //this.c_group(); 
        //document.write(s);
        return '+{'+this.add+'}-{'+this.sub+'}';
    }
    
    this.c_group();
}*/

function simplify_foo(t){
    var s={}; // simplified token
    s.add=[];
    s.sub=[];
    
    // context, expecting group
    this.c_group = function(){
        var i = t.shift(); // get first index 
        if(i=='+')i=t.shift(); // already assume +, so ignore
        
        if(i=='-'){
            // what now, if next is number then push negative number
            // if next is parenthesis, then assume number is 1 and goto new group
            c_negatives();
        } else if(typeof i=='number'){
            s.add.push(i);
            c_group();
        }
        
    }
    this.c_negatives = function(){
        
    }
    this.toString=function(){return 'asdf';}
    
    c_group();
    return s;
}

/**
* Attempts to simplify the solution.
* Note, if you try to do simplify(x)
* and get the same result as last, you're done.
* return token [2,'/',3] for instance
*
* @param array   A token to simplify
*/
function simplify_old(t){
    var s=[]; // simplified token
    // scan for + signs
    for(i=0,end=t.length;i<end;i++){
        /*if(typeof t[i]=='number'){
            num=t[i];
            // now we expect either
            // operator then number
            // or operator then array
            // if array then
            //   solve 
            //   or keep as token (failed to simplify)
        }else */
        // look for +, -, *, /, arrays
        if(t[i]=='+'){
            if(i>0 && i+1<end){
                s.push(t[i-1] + t[i+1]);
                s.push(t.slice(i+2));
            } else {
                throw new Error("Operator expects numbers around itself. TODO: just for now though.");
            }
            break;
        } else if(t[i]=='-'){
        
        }
    }

    return s;
}







/**
* Takes a mathematical formula and calculates the
* decimal numbers instead of returning 2/3 for instance
* return Number
*/
function toDecimal(){

}


/**
* sorts simple calulations first,
* then harder and harder. TODO: do we need it?
*/
function sortstruct(){}


/*
function foo(a, b){
    x = a.slice();// makes an independent copy of array
    this.y = b.slice(); // makes an independent copy of array
    this.z = function(){
        document.write("running z, shifting x and this.y\n");
        x.shift();
        document.write('remaining of x: '+x+"\n");
        this.y.shift();
        document.write('remaining of this.y: '+this.y+"\n");
    }
    z();
}
aaa=[1,2,3];
bbb=[1,2,3];
foo(aaa,bbb);
document.write('remaining of aaa: '+aaa+"\n");
document.write('remaining of bbb: '+bbb+"\n");
*/

try{
    var formula=[
        "x=12+5-4+(5a^2+1)",
        "4+5",
        "2-4+5"
    ];
    for(var i=0,end=formula.length;i<end;i++){
        var str = formula[i];
        var token = tokenize(str);
        var simp = new struct(token);
        document.write(str+"\n");
        document.write("t   "+token+"\n");
        document.write("s   "+simp+"\n\n");
    }
}catch(e){
    document.write(e);
}

//tokenize("-43-(3+4)");
//tokenize("(12+5)");
//tokenize("+56+5");