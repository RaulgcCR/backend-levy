class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def parser(palabra)
  dict_1= {":"=>"D", "/"=>"S","."=>"P","_"=>"R","-"=>"G",","=>"C","&"=>"A","%"=>"V","="=>"E","?"=>"I","@"=>"K",
    "!"=>"U","#"=>"W","¡"=>"B","¿"=>"F","<"=>"H",">"=>"J","["=>"L","]"=>"M","("=>"N",")"=>"O","\n"=>"Q",
    "\""=>"T"," "=>"X",";"=>"Y", "$"=>"Z", "á"=>"_A", "é"=>"_E", "í"=>"_I", "ó"=>"_O", "ú"=>"_U", "Á"=>"_B", "É"=>"_C","Í"=>"_D", "Ó"=>"_F", "Ú"=>"_G", "*"=>"_H","{"=>"_J","}"=>"_K"}
  cont= palabra.length
  code=""
  cont = cont -1
  while cont >= 0 do
    if dict_1.key?(palabra.at(cont)) 
      code = dict_1[palabra.at(cont)] + code 
    elsif  numeric?(palabra.at(cont)) or is_lower?(palabra.at(cont))
      code =  palabra.at(cont) + code 
    elsif is_upper?(palabra.at(cont))
      code =  "_" + palabra.at(cont).downcase + code
    end
    cont= cont - 1
  end
  return code
end

def deparser(palabra)
  dict_1= {"D"=>":", "S"=>"/","P"=>".","R"=>"_","G"=>"-","C"=>",","A"=>"&","V"=>"%","E"=>"=","I"=>"?","K"=>"@","U"=>"!","W"=>"#","B"=>"¡","F"=>"¿","H"=>"<","J"=>">","L"=>"[","M"=>"]","N"=>"(","O"=>")","Q"=>"\n","T"=>"\"","X"=>" ","Y"=>";","Z"=>"$"}
  dict_2= { "A"=>"á","E"=>"é","I"=>"í","O"=>"ó","U"=>"ú","B"=>"Á","C"=>"É","D"=>"Í","F"=>"Ó","G"=>"Ú","H"=>"*","J"=>"{","K"=>"}"}
  resultado=""
  est= 1
  cont= palabra.length
  cant = 0
  while cant  < cont do
    if est == 0
      if is_upper?(palabra.at(cant))
        resultado = resultado + dict_2[palabra.at(cant)] 
      else
        resultado+= palabra.at(cant).upcase
      end
      est= 1
    elsif palabra.at(cant)=="_"
      est = 0
    elsif dict_1.key?(palabra.at(cant))
      resultado=  resultado + dict_1[palabra.at(cant)] 
    elsif is_lower?(palabra.at(cant)) or numeric?(palabra.at(cant))
      resultado= resultado + palabra.at(cant)
    end
    cant = cant  + 1
  end
  return resultado
end

def is_upper?(letter)
	letter == letter.upcase
end

def is_lower?(letter)
    letter == letter.downcase
end

def numeric?(letter)
	letter =~ /[0-9]/
end

def createToken
	random_token = SecureRandom.hex
	return random_token
end

end
