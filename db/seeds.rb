# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
# Refinery::Pages::Engine.load_seed  # Commented out in order to seed my own data

# Create image in order to be able to load in a page later
moneda_social_path = "#{Rails.root.join('app/assets/images/monedasociallogo.png')}"
image_moneda_social= Refinery::Image.create :image => File.new(moneda_social_path)

work_path = "#{Rails.root.join('app/assets/images/work.jpg')}"
image_work= Refinery::Image.create :image => File.new(work_path)

horno_path = "#{Rails.root.join('app/assets/images/horno.jpg')}"
image_horno = Refinery::Image.create :image => File.new(horno_path)

pa_de_coca_path = "#{Rails.root.join('app/assets/images/padecoca.jpg')}"
image_pa_de_coca = Refinery::Image.create :image => File.new(pa_de_coca_path)

soques_path = "#{Rails.root.join('app/assets/images/soques.jpg')}"
image_soques = Refinery::Image.create :image => File.new(soques_path)

pages_array = [ {
                    :show_in_menu => true,
                    :deletable => false,
                    :link_url => "/",
                    :menu_match => "^/$",
                    :title => "Qui som?",  # default english title
                    :title_es => "Quienes somos?",
                    :title_ca => "Qui som?",
                    # Image path in next line is copied from the ui when I try to add it manually
                    :body => "<h4>Qui som?</h4>
                            <p>
                    		  	La Fogaina és un petit projecte autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
                    		  	<ul>
                                 <li>Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals. Les altres farines que utilitzem son de Moulin de Colagne, molí medieval de pedra que treballa amb farines ecològiques de gran qualitat.</li>
                                 <li>Una manipulació manual i casolana, amb fermentacions llargues. Gràcies a això el pa sembla que estigui especiat. Simplement aconseguim treure tot el sabor als cereals.</li>
                                 <li>Hem elaborat la nostra Massa Mare, que ens acompanya desde el 2011, sistema arcaic de llevar el pa, com s'ha fet tota la vida. Tots els productes porten massa mare.</li>
                                 <li>El nostre forn de llenya es de foc directe, d'aquesta manera reduïm el consum d'electricitat i aportem al pa un olor característic.</li>
                                 <li>Informar sempre a la gent que ens visita del que fem, i com ho fem, sense secrets ni falta d'informació. Ens preocupem pels gustos particulars i aconsellem. Emboliquem i entreguem el pa amb la satisfacció de la feïna ben feta. I també molt important, no pugem els preus per tot aixó.</li>
                              	</ul>
							  	Bon Profit!!!
                    		  </p>",
                    :body_es => "",
                    :body_ca => "",     
                    # Add a Tweet from your Tweeter account( Source from https://dev.twitter.com/web/embedded-tweets ) 
                    #               <blockquote class=\"twitter-tweet\" lang=\"en\"><p lang=\"und\" dir=\"\ltr\">Avui merendola  especial a <a href=\"https://twitter.com/lanevateria\">@lanevateria</a> . <a href=\"https://twitter.com/hashtag/boncafe?src=hash\">#boncafe</a> <a href=\"https://twitter.com/hashtag/barista?src=hash\">#barista</a> <a href=\"https://twitter.com/hashtag/croissant?src=hash\">#croissant</a> <a href=\"https://twitter.com/hashtag/olot?src=hash\">#olot</a> @ La Nevateria <a href=\"https://t.co/80KGy04fBT\">https://t.co/80KGy04fBT</a></p>&mdash; Forn La Fogaina (@Fogaina) <a href=\"https://twitter.com/Fogaina/status/654336873951850496\">October 14, 2015</a></blockquote>
                    #               <script async src=\"//platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>              
                    :side_body => "<h4>Treball</h4>
                                  <p>Feu clic a cada imatge per veure el nostre treball!</p>
                                  <ul class=\"clearing-thumbs small-block-grid-1 medium-block-grid-2 large-block-grid-4\" data-clearing>
                                    <li>
                                      <img data-caption=\"Preparando el pan ...\" src=\"%s\">
                                    </li>
                                    <li>
                                      <img data-caption=\"Nuestro horno ...\" src=\"%s\">
                                    </li>
                                    <li>
                                      <img data-caption=\"Pade coca\" src=\"%s\">
                                    </li>
                                    <li>
                                      <img data-caption=\"Soques recién hechas\" src=\"%s\">
                                    </li>
                                  </ul>
                                   <p><h4>Acceptem moneda social</h4><p>
                                   <img height=\"66\" width=\"183\" data-interchange=\"[%s, (default)]]\">" % [image_work.url, image_horno.url, image_pa_de_coca.url, image_soques.url, image_moneda_social.url],                  
                    #:position_side_body => 0,
                    #:banner => banner_html[:default],
                    #:banner_es => banner_html[:es],
                    #:banner_ca => banner_html[:ca],
                    #:position_banner => 0,
                    :position_body => 1,
                    :children =>  {
                        :show_in_menu => false,
                        :deletable => false,
                        :menu_match => "^/404$",
                        :title => "Pagina no trobada",
                        :title_es => "Página no encontrada",
                        :title_ca => "Pàgina no trobada",
                        :position_body => 0,
                        :body => "<h2>Upsss! Sorry, there has been a problem ...</h2><p>The page is not available.</p><p><a href='/'>Back to home</a></p>",
                        :body_es => "<h2>Upsss! Lo sentimos, ha habido un problema ...</h2><p>La página solicitada no ha sido encontrada.</p><p><a href='/es'>Vuelva a la página de inicio</a></p>",
                        :body_ca => "<h2>Upsss! Ho sentim, hi ha hagut un problema ...</h2><p>La pàgina sol-licitada no s'ha trobat.</p><p><a href='/ca'>Tornar a la pàgina de inici</a></p>",
                    }
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Blog",  
                    :title_es => "Blog",
                    :title_ca => "Blog",
                    :body => "<h3>La Fogaina - Oclot . Ja tenim servi d'entrega ... Ecològic!!</h3>   
                             <p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).</p>
                             <p>Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa. A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646.879.062 </p>
							 <p>Salut, Pa i Pedals!!!</p>",
                    :body_es => "",
                    :body_ca => ""
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Pa i Cafè",
                    :title_es => "Pa i Cafè",
                    :title_ca => "Pa i Cafè",
                    :body => "<p>La Fogaina ha obert un nou espai més accesible per tothom, al poble de les Preses, hem inaugurat <strong>La Fogaina Pa i Cafè</strong>, un lloc on podeu anar a comprar els nostres productes de sempre, o pendre un bon cafè, una bona cervessa artesana, entrepans amb embotits de la Vall d'en Bas, croissants, ... Tots els productes de fleca els fem nosaltres, al nostre obrador i al nostre forn de llenya.</p>
                    		 <p>Hem intentat crear un espai amb caliu, personal, per poder pendre algo tranquilament. També tenim una estanteria-llibreria, amb llibres de consulta i llibres en venda de <a target=\"_blank\" title=\"http://www.takatuka.cat\" href=\"http://www.takatuka.cat\">Takatuka</a> i <a target=\"_blank\" title=\"http://pol-len.cat\" href=\"http://pol-len.cat\">Pol.len Edicions</a>, llibres preciosos.</p>
                    		 <p>Otra cosa peculiar de nuestro local, es que practicamente lo hemos hecho todo nosotros, los muebles de madera y el hierro en forja son artesanos, ademas de apaños de albañileria, fontaneria, electricidad... </p>
                    		 <p>També hem creat un petit raconet pels més petits, perque puguin jugar i divertirse i així els grans podem esmorçar tranquil.lament llegint o xerrant. </p>
							 <p>Si ens voleu visitar, estem al Carrer Sant Sebastià nº 52 de les Preses, a 10 metres de la carretera que va cap a Olot. <strong>Obrim de Dimarts a Dissabte, de 8:00 a 13:30 i de 16:00 a 20:00.</strong></p>
							 <p>A la botiga que tenim a l'obrador, a la Masia, continuarem obrint però nomès els dissabtes de 9:30 a 13:00. Estem a la carretera del Veïnat Cirera, Mas la Plana s/n. </p>",
                    :body_es => "",
                    :body_ca => ""
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Contacte",  # default german title
                    :title_es => "Contacto",
                    :title_ca => "Contacte",
                    :body => "<h3>La Fogaina</h3>
						  	  <p>Dissabtes de 9:30 a 13:30 </p>
							  <p>Mas la Plana s/n </br> El Mallol - Carretera del Veïnat Cirera. </br> La Vall d'en Bas. </br> La Garrotxa - Girona </br> 661380955 - 639264863</p>
							  <p>fornlafogaina@gmail.com </br> (obrador, contacte per restaurants, cooperatives etc)</p>
 							  <h3>La Fogaina Pa i Cafè.</h3>
							  <p>De Dimarts a Dissabte, de 8:00 a 13:30 i de 16:00 a 20:00 </p>
							  <p>C/ Sant Sebastià nº52 </br> Les Preses</br> La Garrotxa - Girona</br> 646879062</p>
							  <p>cafelafogaina@gmail.com </br> (espai cafe, venda de pa i reposteria, contacte per particulars)</p>                                                     
                              <p>Enllaç a <a target=\"_blank\" title=\"\" href=\"https://www.google.es/maps?q=forn+la+fogaina&hl=es&ll=42.153414,2.453814&spn=0.009688,0.021136&sll=40.396764,-3.713379&sspn=10.185894,21.643066&t=h&z=16&iwloc=A\">Google Maps</a></p>",
                    :body_es => "",
                    :body_ca => ""
                }
]

def finnish_page( page, page_attr )
  page.translations.create!( { :locale => 'es', :title => page_attr[:title_es] } )
  page.translations.create!( { :locale => 'ca', :title => page_attr[:title_ca] } )

  page_body_part = page.parts.create!( { :title => "Body", :body => page_attr[:body], :position => page_attr[:position_body] } )

  page_body_part.translations.create!( { :locale => "es", :body => page_attr[:body_es] } )
  page_body_part.translations.create!( { :locale => "ca", :body => page_attr[:body_ca] } )

  if page_attr.has_key?(:banner)

    page_banner_part = page.parts.create!( { :title => "Banner", :body => page_attr[:banner], :position => page_attr[:position_banner] } )

    page_banner_part.translations.create!( { :locale => "es", :body => page_attr[:banner_es] } )
    page_banner_part.translations.create!( { :locale => "ca", :body => page_attr[:banner_ca] } )

  end

  if page_attr.has_key?(:side_body)

    page_side_body_part = page.parts.create!( { :title => "Side Body", :body => page_attr[:side_body], :position => page_attr[:position_side_body] } )

    page_side_body_part.translations.create!( { :locale => "es", :body => page_attr[:side_body_es] } )
    page_side_body_part.translations.create!( { :locale => "ca", :body => page_attr[:side_body_ca] } )

  end

  if page_attr.has_key?(:children)

    children_attr = page_attr[:children]

    page_children = page.children.create!( :title => children_attr[:title],
                                           :menu_match => children_attr[:menu_match],
                                           :show_in_menu => children_attr[:menu_match],
                                           :deletable => children_attr[:deletable] )

    page_children.translations.create!( { :locale => "es", :title => children_attr[:title_es] } )
    page_children.translations.create!( { :locale => "ca", :title => children_attr[:title_ca] } )

    page_children_body_part = page_children.parts.create!( { :title => "Body", :body => children_attr[:body], :position => children_attr[:position_body] } )

    page_children_body_part.translations.create!( { :locale => "es", :body => children_attr[:body_es] } )
    page_children_body_part.translations.create!( { :locale => "ca", :body => children_attr[:body_ca] } )
  end
end


# Start here ...
pages_array.each { | page_attr |

  page_is_root = page_attr.has_key?(:menu_match) && page_attr.has_key?(:link_url) && page_attr.has_key?(:position_body)

  # Call page constructor based on the attributes available
  page = ( page_is_root ) ?
      # Just for the root page
      Refinery::Page.create!( { :show_in_menu => page_attr[:show_in_menu],
                                :deletable => page_attr[:deletable],
                                :link_url => page_attr[:link_url],
                                :menu_match => page_attr[:menu_match],
                                :title => page_attr[:title] } ) :
      # For the rest of pages
      Refinery::Page.create!( { :show_in_menu => page_attr[:show_in_menu],
                                :deletable => page_attr[:deletable],
                                :title => page_attr[:title] } )

  finnish_page( page, page_attr )
}
