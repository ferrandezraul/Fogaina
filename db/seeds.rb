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
#moneda_social_path = "#{Rails.root.join('app/assets/images/monedasociallogo.png')}"
#image_moneda_social= Refinery::Image.create :image => File.new(moneda_social_path)

# Added by Refinery CMS Image Slides extension
Refinery::ImageSlideshows::Engine.load_seed

espai_path = "#{Rails.root.join('app/assets/images/cafeteria/espai.jpg')}"
image_espai= Refinery::Image.create :image => File.new(espai_path)

cistell_pan_path = "#{Rails.root.join('app/assets/images/pan/cistell.jpg')}"
image_cistell_pan = Refinery::Image.create :image => File.new(cistell_pan_path)

cursos_cartell_path = "#{Rails.root.join('app/assets/images/cursos/cursos_cartell.jpg')}"
image_cursos_cartell = Refinery::Image.create :image => File.new(cursos_cartell_path)

soques_path = "#{Rails.root.join('app/assets/images/pan/soques.jpg')}"
image_soques = Refinery::Image.create :image => File.new(soques_path)

obrador_reposteria_path = "#{Rails.root.join('app/assets/images/obrador/reposteria1000x400.jpg')}"
image_obrador_reposteria= Refinery::Image.create :image => File.new(obrador_reposteria_path)

slide_image_obrador_reposteria = Refinery::ImageSlideshows::ImageSlide.create!( :title => "Reposteria", :image_id => image_obrador_reposteria.id )
slide_image_obrador_reposteria.translations.create!( :locale => :ca, :title => "Reposteria" )

cafeteria_path = "#{Rails.root.join('app/assets/images/cafeteria/cafeteria1000x400.jpg')}"
image_cafeteria= Refinery::Image.create :image => File.new(cafeteria_path)

slide_image_cafeteria = Refinery::ImageSlideshows::ImageSlide.create!( :title => "Cafeteria", :image_id => image_cafeteria.id )
slide_image_cafeteria.translations.create!( :locale => :ca, :title => "Cafeteria" )

croi_path = "#{Rails.root.join('app/assets/images/reposteria/croi1000x400.jpg')}"
image_croi= Refinery::Image.create :image => File.new(croi_path)

slide_image_croi = Refinery::ImageSlideshows::ImageSlide.create!( :title => "Croi", :image_id => image_croi.id )
slide_image_croi.translations.create!( :locale => :ca, :title => "Croi" )

slider = Refinery::ImageSlideshows::ImageSlideshow.create!( :title => "Home Page Slide Show")
slider.image_slides = [ slide_image_obrador_reposteria, slide_image_cafeteria, slide_image_croi ]

pages_array = [ {
                    :show_in_menu => true,
                    :deletable => false,
                    :link_url => "/",
                    :menu_match => "^/$",
                    :title => "Home",  # default english title
                    :title_es => "Inicio",
                    :title_ca => "Inici",
                    # Image path in next line is copied from the ui when I try to add it manually
                    :body => "
                    <div class=\"row\">
                    <div class=\"large-12 columns\">
                      <div class=\"panel\">
                        <h4>Organic hand made bread in la Garrotxa!</h4>
                        <div class=\"row\">
                          <div class=\"large-9 columns\">
                            <p>Come and visit our cafeteria.</p>
                          </div>
                          <div class=\"large-3 columns\">
                            <a href=\"contacte\" class=\"radius button right\"><i class=\"fi-marker\"> We are here!</i></a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                    <p>La Fogaina is a project that .... autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals. Les altres farines que utilitzem son de Moulin de Colagne, molí medieval de pedra que treballa amb farines ecològiques de gran qualitat.</p>
                    <div class=\"row\">
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Project</h4>
                      <p>La Fogaina és un petit projecte autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals.</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cafeteria</h4>
                      <p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).
                      Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646 879 062
</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Courses</h4>
                      <p>Si voleu apuntar-vos a la nostra llista de mail, per estar informats dels cursos que anem programant, envieu un mail a: fornlafogaina@gmail.com , i ens expliqueu el motiu.
Normalment les places pels cursos son màxim de 7 persones, per poder gaudir de l'espai i de l'aprenentatge. Tots el cursos es poden pagar amb moneda social.</p>
                    </div>
                  </div>" % [image_cistell_pan.url, image_espai.url, image_cursos_cartell.url],
                    :body_es => "
                    <div class=\"row\">
                    <div class=\"large-12 columns\">
                      <div class=\"panel\">
                        <h4>Pan artesano i ecológico en la Garrotxa!</h4>
                        <div class=\"row\">
                          <div class=\"large-9 columns\">
                            <p>Ven a ver nuestra cafeteria.</p>
                          </div>
                          <div class=\"large-3 columns\">
                            <a href=\"contacte\" class=\"radius button right\"><i class=\"fi-marker\"> Estamos aquí!</i></a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                    <p>La Fogaina es un proyecto .... autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals. Les altres farines que utilitzem son de Moulin de Colagne, molí medieval de pedra que treballa amb farines ecològiques de gran qualitat.</p>
                    <div class=\"row\">
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Proyecto</h4>
                      <p>La Fogaina és un petit projecte autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals.</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cafeteria</h4>
                      <p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).
                      Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646 879 062
</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cursos</h4>
                      <p>Si voleu apuntar-vos a la nostra llista de mail, per estar informats dels cursos que anem programant, envieu un mail a: fornlafogaina@gmail.com , i ens expliqueu el motiu.
Normalment les places pels cursos son màxim de 7 persones, per poder gaudir de l'espai i de l'aprenentatge. Tots el cursos es poden pagar amb moneda social.</p>
                    </div>
                  </div>" % [image_cistell_pan.url, image_espai.url, image_cursos_cartell.url],
                    :body_ca => "
                    <div class=\"row\">
                    <div class=\"large-12 columns\">
                      <div class=\"panel\">
                        <h4>Pa artesà i ecològic a la Garrotxa!</h4>
                        <div class=\"row\">
                          <div class=\"large-9 columns\">
                            <p>Vine a veure la nostra cafeteria.</p>
                          </div>
                          <div class=\"large-3 columns\">
                            <a href=\"contacte\" class=\"radius button right\"><i class=\"fi-marker\"> Estem aquí!</i></a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                    <p>La Fogaina es un projecte autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals. Les altres farines que utilitzem son de Moulin de Colagne, molí medieval de pedra que treballa amb farines ecològiques de gran qualitat.</p>
                    <div class=\"row\">
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Projecte</h4>
                      <p>La Fogaina és un petit projecte autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals.</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cafeteria</h4>
                      <p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).
                      Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646 879 062
</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cursos</h4>
                      <p>Si voleu apuntar-vos a la nostra llista de mail, per estar informats dels cursos que anem programant, envieu un mail a: fornlafogaina@gmail.com , i ens expliqueu el motiu.
Normalment les places pels cursos son màxim de 7 persones, per poder gaudir de l'espai i de l'aprenentatge. Tots el cursos es poden pagar amb moneda social.</p>
                    </div>
                  </div>" % [image_cistell_pan.url, image_espai.url, image_cursos_cartell.url],    
                    :side_body => "", 
                    :side_body_es => "",
                    :side_body_ca => "",                  
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
                        :body => "<h4>Upsss! Sorry, there has been a problem ...</h4><p>The page is not available.</p><p><a href='/'>Back to home</a></p>",
                        :body_es => "<h4>Upsss! Lo sentimos, ha habido un problema ...</h4><p>La página solicitada no ha sido encontrada.</p><p><a href='/es'>Vuelva a la página de inicio</a></p>",
                        :body_ca => "<h4>Upsss! Ho sentim, hi ha hagut un problema ...</h4><p>La pàgina sol-licitada no s'ha trobat.</p><p><a href='/ca'>Tornar a la pàgina de inici</a></p>",
                    }
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Bread and Coffee",
                    :title_es => "Pan i Café",
                    :title_ca => "Pa i Cafè",
                    :body => "<p>This is the body of Bread and coffee.</p>",
                    :body_es => "<p>Esto es el body de Pan i Cafe.</p>",
                    :body_ca => "<p>Això es el body de pa i cafe</p>",
                    :side_body => "<p>This is the side body of Bread and Coffee.</p>", 
                    :side_body_es => "<p>Esto es el side body de Pan in Cafe.</p>",
                    :side_body_ca => "<p>Això es el side body de Pa i Cafe</p>", 
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Media",
                    :title_es => "Media",
                    :title_ca => "Media",
                    :body => "<p>This is the body of Media.</p>",
                    :body_es => "<p>Esto es el body de Media.</p>",
                    :body_ca => "<p>Això es el body de Media</p>",
                    :side_body => "<p>This is the side body of Media.</p>", 
                    :side_body_es => "<p>Esto es el side body de Media.</p>",
                    :side_body_ca => "<p>Això es el side body de Media</p>", 
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Wanna know more?",
                    :title_es => "Quieres saber mas?",
                    :title_ca => "Vols saber més?",
                    :body => "<p>This is the body of Wanna know more?",
                    :body_es => "<p>Esto es el body de Quieres saber mas</p>",
                    :body_ca => "<p>Això es el body de Vols saber mes?</p>",
                    :side_body => "<p>This is the side body of Wanna know more?</p>", 
                    :side_body_es => "<p>Esto es el side body de Quieres saber mas?</p>",
                    :side_body_ca => "<p>Això es el side body de Vols saber mes?</p>",
                    :children =>  {
                        :show_in_menu => true,
                        :deletable => true,
                        :title => "Courses",
                        :title_es => "Cursos",
                        :title_ca => "Cursos",
                        :body => "<p>Coming soon ...</p><p><a href='/'>Back to home</a></p>",
                        :body_es => "<p>Proximamente ...</p><p><a href='/'>Volver al inicio</a></p>",
                        :body_ca => "<p>Proximament ...</p><p><a href='/'>Tornar a l'inici</a></p>"
                    }
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Contacte",  # default german title
                    :title_es => "Contacto",
                    :title_ca => "Contacte",
                    :body => "<div class=\"row\">
                                <div class=\"large-12 columns\">
                                  <div class=\"large-4 columns\">
                                    <div class=\"panel\">
                                      <h4>La Fogaina</h4>
                                      <p>Saturday from 9:30h until 13:30h </p>
                                      <p><i class=\"fi-marker\"> Mas la Plana s/n, El Mallol, Carretera del Veïnat Cirera. La Vall d'en Bas, Girona</i><br><i class=\"fi-telephone\"> 661 38 09 55</i> / <i class=\"fi-telephone\"> 639 26 48 63</i></p>
                                    </div>
                                    <div class=\"panel\">
                                      <h4>La Fogaina Pa i Cafè.</h4>
                                      <p>Tuesday to Saturday from 8:00h until 13:30h and from 16:00h until 20:00h</p>
                                      <p><i class=\"fi-marker\"> c/ Sant Sebastià nº52, Les Preses, Girona</i><br><i class=\"fi-telephone\"> 646 87 90 62</i></p>
                                    </div>
                                  </div>
                                  <div class=\"large-8 columns\">
                                    <div id=\"map-fogaina\"></div>
                                  </div>
                                </div>
                              </div>",
                    :body_es => "<div class=\"row\">
                                <div class=\"large-12 columns\">
                                  <div class=\"large-4 columns\">
                                    <div class=\"panel\">
                                      <h4>La Fogaina</h4>
                                      <p>Sábados de 9:30h a 13:30h </p>
                                      <p><i class=\"fi-marker\"> Mas la Plana s/n, El Mallol, Carretera del Veïnat Cirera. La Vall d'en Bas, Girona</i><br><i class=\"fi-telephone\"> 661 38 09 55</i> / <i class=\"fi-telephone\"> 639 26 48 63</i></p>
                                    </div>
                                    <div class=\"panel\">
                                      <h4>La Fogaina Pa i Cafè.</h4>
                                      <p>De Martes a Sábado de 8:00h a 13:30h i de 16:00h a 20:00h</p>
                                      <p><i class=\"fi-marker\"> c/ Sant Sebastià nº52, Les Preses, Girona</i><br><i class=\"fi-telephone\"> 646 87 90 62</i></p>
                                    </div>
                                  </div>
                                  <div class=\"large-8 columns\">
                                    <div id=\"map-fogaina\"></div>
                                  </div>
                                </div>
                              </div>",
                    :body_ca => "<div class=\"row\">
                                <div class=\"large-12 columns\">
                                  <div class=\"large-4 columns\">
                                    <div class=\"panel\">
                                      <h4>La Fogaina</h4>
                                      <p>Dissabtes de 9:30h a 13:30h </p>
                                      <p><i class=\"fi-marker\"> Mas la Plana s/n, El Mallol, Carretera del Veïnat Cirera. La Vall d'en Bas, Girona</i><br><i class=\"fi-telephone\"> 661 38 09 55</i> / <i class=\"fi-telephone\"> 639 26 48 63</i></p>
                                    </div>
                                    <div class=\"panel\">
                                      <h4>La Fogaina Pa i Cafè.</h4>
                                      <p>De Dimarts a Dissabte de 8:00h a 13:30h i de 16:00h a 20:00h</p>
                                      <p><i class=\"fi-marker\"> c/ Sant Sebastià nº52, Les Preses, Girona</i><br><i class=\"fi-telephone\"> 646 87 90 62</i></p>
                                    </div>
                                  </div>
                                  <div class=\"large-8 columns\">
                                    <div id=\"map-fogaina\"></div>
                                  </div>
                                </div>
                              </div>"
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
                                           :show_in_menu => children_attr[:show_in_menu],
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

# Added by Refinery CMS Breads extension
Refinery::Breads::Engine.load_seed
