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

# Create one single user in order to avoid entering a user in development mode
if Rails.env.development?
  admin_user = Refinery::Authentication::Devise::User.create!( :username => 'test',
                                                :email => "test@test.com", 
                                                :password => 'test')

  # Add necessary roles
  # https://groups.google.com/d/msg/refinery-cms/akI74wnviFs/j613apqJdvgJ
  admin_user.add_role :refinery
  admin_user.add_role :superuser
end

# Create some settings in order to enable or disable the site for other locales
# Note that in app/views/refinery/_header.html.erb those settings are checked in order
# to display or not the locale switch
Refinery::Setting.find_or_set( :spanish_web, true )
setting_es = Refinery::Setting.find_by!( name: :spanish_web )
setting_es.update!( title: "Habilitar la web en castellà")

Refinery::Setting.find_or_set( :english_web, true )
setting_en = Refinery::Setting.find_by!( name: :english_web )
setting_en.update!( title: "Habilitar la web en anglès")

# Added by Refinery CMS Image Slides extension
Refinery::ImageSlideshows::Engine.load_seed

# Path to images in SLIDE SHOW IN HOME PAGE
slideshow_img1_path = "#{Rails.root.join('app/assets/images/slideshow/1000x400/IMG_2178.jpg')}"
slideshow_img2_path = "#{Rails.root.join('app/assets/images/slideshow/1000x400/IMG_2550.jpg')}"
slideshow_img3_path = "#{Rails.root.join('app/assets/images/slideshow/1000x400/IMG_1523.jpg')}"
slideshow_img4_path = "#{Rails.root.join('app/assets/images/slideshow/1000x400/IMG_1724.jpg')}"
slideshow_img5_path = "#{Rails.root.join('app/assets/images/slideshow/1000x400/IMG_3421.jpg')}"
slideshow_img6_path = "#{Rails.root.join('app/assets/images/slideshow/1000x400/IMG_4151.jpg')}"
slideshow_img7_path = "#{Rails.root.join('app/assets/images/slideshow/1000x400/IMG_4751.jpg')}"

# Images in SLIDE SHOW IN HOME PAGE
slideshow_img1 = Refinery::Image.create :image => File.new(slideshow_img1_path)
slideshow_img2 = Refinery::Image.create :image => File.new(slideshow_img2_path)
slideshow_img3 = Refinery::Image.create :image => File.new(slideshow_img3_path)
slideshow_img4 = Refinery::Image.create :image => File.new(slideshow_img4_path)
slideshow_img5 = Refinery::Image.create :image => File.new(slideshow_img5_path)
slideshow_img6 = Refinery::Image.create :image => File.new(slideshow_img6_path)
slideshow_img7 = Refinery::Image.create :image => File.new(slideshow_img7_path)

slide_images = [
  {
    :title => "1", 
    :image_id => slideshow_img1.id 
  },
  {
    :title => "2", 
    :image_id => slideshow_img2.id 
  },
  {
    :title => "3", 
    :image_id => slideshow_img3.id 
  },
  {
    :title => "4", 
    :image_id => slideshow_img4.id 
  },
  {
    :title => "5", 
    :image_id => slideshow_img5.id 
  },
  {
    :title => "6", 
    :image_id => slideshow_img6.id 
  },
  {
    :title => "7", 
    :image_id => slideshow_img7.id 
  }
]

#binding.pry

slide_images.each do | slide_image |

  refinery_image_slide = Refinery::ImageSlideshows::ImageSlide.create!( 
    :title => slide_image[:title], 
    :image_id => slide_image[:image_id] )

  refinery_image_slide.translations.create!( :locale => :ca, :title => slide_image[:title] )
  refinery_image_slide.translations.create!( :locale => :es, :title => slide_image[:title] )
end

slider = Refinery::ImageSlideshows::ImageSlideshow.create!( :title => "Carrousel d'imatges de la pagina d'inici")
slider.image_slides = Refinery::ImageSlideshows::ImageSlide.all.to_a

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
                              <a href=\"contact\" class=\"radius button right\"><i class=\"fi-marker\"> We are here!</i></a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>",
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
                              <a href=\"contact\" class=\"radius button right\"><i class=\"fi-marker\"> Estamos aquí!</i></a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>",
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
                              <a href=\"contact\" class=\"radius button right\"><i class=\"fi-marker\"> Estem aquí!</i></a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>",    
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
                    :title => "Who are we?",
                    :title_es => "Quienes somos?",
                    :title_ca => "Qui som",
                    :view_template => "qui_som", # custom view template (see /app/views/refinery/pages/qui_som.html.erb)
                    :body => "<p>Avui, La Fogaina som un col·lectiu de 5 socis que treballem de forma cooperativa i assembleària. Va nèixer en un primer moment d'una necessitat econòmica familiar, la necessitat de sortir de la precarietat laboral i aconseguir una estabilitat que feia temps que no teníem. Acabàvem d'aterrar a la Garrotxa, era el 2011 i just llavors vaig descobrir una passió que no sabia que tenia, fer pa.</p>
                              <p>Recordo amb un somriure els primers dies que vaig començar a indagar en aquest món panarra, sobretot via internet, visitant fòrums, webs i vídeos; al·lucinava amb la quantitat de tècniques i mètodes que existien, que no podia evitar provar, i convertia la cuina de casa a qualsevol hora del dia o de la nit en el laboratori d'un alquimista boig. Va ser quan vaig fer la nostra primera massa mare natural, que encara avui ens acompanya cada dia a la feina.
                              No negaré que el salt de forner casolà a professional va ser una bogeria, un gran pas on hi ha massa aspectes que no controles i no els veus venir fins que te'ls trobes de cop. No vinc d'una família de forners, ni he estudiat a l'escola de flequers Allò que realment necessitava, com poder formar-me a l'estranger on sí que considerava que hi havia bon pa i bones escoles, ja se'm feia molt difícil: arrossegar a tota la família a França, o Alemanya, sense idioma, sense diners, a estudiar en escoles normalment bastant cares ...
                              Així que gairebé que no ens va quedar més remei que tirar-nos-hi de cap ... sense saber nedar, sense flotador ni braçals ... gairebé ens ofeguem. És un ofici dur i el camí escollit no és el més fàcil, però ens mantenim a flotació , i les aigües ja van més tranquil·les.
                              Sort de la quantitat de gent que pel camí ens ha ajudat, de moltes maneres, sense ells no ho hauríem aconseguit. Sona tòpic, però és cert.</p>
                              <p>Tanmateix i sobretot, el que més ens ha importat ha estat la qualitat del nostre producte. Sempre ens hem preocupat per aprendre i millorar, i per això hem visitat i conegut forners i fleques que ens han aportat tècniques, mètodes, il·lusió i passió per l'ofici. Com la petita fleca regentada per un sol forner, l'Stephane, un projecte preciós del sud de França del qual gairebé vam ser un mirall durant els dos primers anys: farines ecològiques, massa mare, forn de llenya i un procés molt manual. També, vam tenir la sort de visitar The loaf, un projecte de fleca efímera a Donosti, amb Dan Lepard al capdavant, un forner molt experimentat i millor persona. Ens van obrir les portes a poder treballar 3 dies braç a braç a l'obrador, va ser màgic i increïble, l'oportunitat de pastar, formar i enfornar desenes de pans, viure el ritme real d'un obrador, compartir xerrades amb autèntics cracs com el mateix Dan i els forners que treballaven allà: Iban Yarza, amb qui hem coincidit altres vegades; Pablo Conesa, de Sevilla, que estava de visita, molts panarres casolans..., un autèntic luxe.</p>
                              <p>A poc a poc, ha anat entrant gent nova al projecte, al principi per aprendre i ajudar a l'obrador, després per muntar la fleca-cafeteria al poble i de seguida, per afegir el punt dolç que ens faltava. És aquest un moment important en la nostra petita història, quan vam decidir, amb dues famílies més, convertir La Fogaina, en un projecte cooperatiu, on 5 socis decidim de manera assembleària el nostre futur, tot gestionant l'obrador i la fleca-cafeteria amb l'objectiu de mantenir i millorar la nostra qualitat i la nostra producció, i tenir una feina i sou dignes. Ens hi anem acostant. Quan decideixes convertir un projecte familiar en un projecte cooperatiu assumeixes que comences a treballar en equip, sumant i aportant idees i energia al projecte, i això dóna força i moral en els moments difícils.</p>
                              <p>Estem molt orgullosos del que hem aconseguit fins ara, treballem dur i tenim un producte honest i saludable. La Fogaina és una suma dels qui la formem, de manera que és més viva que mai. Sembla clar que, com fa cada dia la nostra massa mare, continuarem creixent, amb noves idees i encara més sorpreses.
                              Esperem que gaudiu dels nostres productes, del nostre espai i del nostre tracte…</p>
                              <p><a href='/'>Back to home</a></p>",
                    :body_es => "<p>Avui, La Fogaina som un col·lectiu de 5 socis que treballem de forma cooperativa i assembleària. Va nèixer en un primer moment d'una necessitat econòmica familiar, la necessitat de sortir de la precarietat laboral i aconseguir una estabilitat que feia temps que no teníem. Acabàvem d'aterrar a la Garrotxa, era el 2011 i just llavors vaig descobrir una passió que no sabia que tenia, fer pa.</p>
                              <p>Recordo amb un somriure els primers dies que vaig començar a indagar en aquest món panarra, sobretot via internet, visitant fòrums, webs i vídeos; al·lucinava amb la quantitat de tècniques i mètodes que existien, que no podia evitar provar, i convertia la cuina de casa a qualsevol hora del dia o de la nit en el laboratori d'un alquimista boig. Va ser quan vaig fer la nostra primera massa mare natural, que encara avui ens acompanya cada dia a la feina.
                              No negaré que el salt de forner casolà a professional va ser una bogeria, un gran pas on hi ha massa aspectes que no controles i no els veus venir fins que te'ls trobes de cop. No vinc d'una família de forners, ni he estudiat a l'escola de flequers Allò que realment necessitava, com poder formar-me a l'estranger on sí que considerava que hi havia bon pa i bones escoles, ja se'm feia molt difícil: arrossegar a tota la família a França, o Alemanya, sense idioma, sense diners, a estudiar en escoles normalment bastant cares ...
                              Així que gairebé que no ens va quedar més remei que tirar-nos-hi de cap ... sense saber nedar, sense flotador ni braçals ... gairebé ens ofeguem. És un ofici dur i el camí escollit no és el més fàcil, però ens mantenim a flotació , i les aigües ja van més tranquil·les.
                              Sort de la quantitat de gent que pel camí ens ha ajudat, de moltes maneres, sense ells no ho hauríem aconseguit. Sona tòpic, però és cert.</p>
                              <p>Tanmateix i sobretot, el que més ens ha importat ha estat la qualitat del nostre producte. Sempre ens hem preocupat per aprendre i millorar, i per això hem visitat i conegut forners i fleques que ens han aportat tècniques, mètodes, il·lusió i passió per l'ofici. Com la petita fleca regentada per un sol forner, l'Stephane, un projecte preciós del sud de França del qual gairebé vam ser un mirall durant els dos primers anys: farines ecològiques, massa mare, forn de llenya i un procés molt manual. També, vam tenir la sort de visitar The loaf, un projecte de fleca efímera a Donosti, amb Dan Lepard al capdavant, un forner molt experimentat i millor persona. Ens van obrir les portes a poder treballar 3 dies braç a braç a l'obrador, va ser màgic i increïble, l'oportunitat de pastar, formar i enfornar desenes de pans, viure el ritme real d'un obrador, compartir xerrades amb autèntics cracs com el mateix Dan i els forners que treballaven allà: Iban Yarza, amb qui hem coincidit altres vegades; Pablo Conesa, de Sevilla, que estava de visita, molts panarres casolans..., un autèntic luxe.</p>
                              <p>A poc a poc, ha anat entrant gent nova al projecte, al principi per aprendre i ajudar a l'obrador, després per muntar la fleca-cafeteria al poble i de seguida, per afegir el punt dolç que ens faltava. És aquest un moment important en la nostra petita història, quan vam decidir, amb dues famílies més, convertir La Fogaina, en un projecte cooperatiu, on 5 socis decidim de manera assembleària el nostre futur, tot gestionant l'obrador i la fleca-cafeteria amb l'objectiu de mantenir i millorar la nostra qualitat i la nostra producció, i tenir una feina i sou dignes. Ens hi anem acostant. Quan decideixes convertir un projecte familiar en un projecte cooperatiu assumeixes que comences a treballar en equip, sumant i aportant idees i energia al projecte, i això dóna força i moral en els moments difícils.</p>
                              <p>Estem molt orgullosos del que hem aconseguit fins ara, treballem dur i tenim un producte honest i saludable. La Fogaina és una suma dels qui la formem, de manera que és més viva que mai. Sembla clar que, com fa cada dia la nostra massa mare, continuarem creixent, amb noves idees i encara més sorpreses.
                              Esperem que gaudiu dels nostres productes, del nostre espai i del nostre tracte…</p>
                              <p><a href='/'>Volver al inicio</a></p>",
                    :body_ca => "<p>Avui, La Fogaina som un col·lectiu de 5 socis que treballem de forma cooperativa i assembleària. Va nèixer en un primer moment d'una necessitat econòmica familiar, la necessitat de sortir de la precarietat laboral i aconseguir una estabilitat que feia temps que no teníem. Acabàvem d'aterrar a la Garrotxa, era el 2011 i just llavors vaig descobrir una passió que no sabia que tenia, fer pa.</p>
                              <p>Recordo amb un somriure els primers dies que vaig començar a indagar en aquest món panarra, sobretot via internet, visitant fòrums, webs i vídeos; al·lucinava amb la quantitat de tècniques i mètodes que existien, que no podia evitar provar, i convertia la cuina de casa a qualsevol hora del dia o de la nit en el laboratori d'un alquimista boig. Va ser quan vaig fer la nostra primera massa mare natural, que encara avui ens acompanya cada dia a la feina.
                              No negaré que el salt de forner casolà a professional va ser una bogeria, un gran pas on hi ha massa aspectes que no controles i no els veus venir fins que te'ls trobes de cop. No vinc d'una família de forners, ni he estudiat a l'escola de flequers Allò que realment necessitava, com poder formar-me a l'estranger on sí que considerava que hi havia bon pa i bones escoles, ja se'm feia molt difícil: arrossegar a tota la família a França, o Alemanya, sense idioma, sense diners, a estudiar en escoles normalment bastant cares ...
                              Així que gairebé que no ens va quedar més remei que tirar-nos-hi de cap ... sense saber nedar, sense flotador ni braçals ... gairebé ens ofeguem. És un ofici dur i el camí escollit no és el més fàcil, però ens mantenim a flotació , i les aigües ja van més tranquil·les.
                              Sort de la quantitat de gent que pel camí ens ha ajudat, de moltes maneres, sense ells no ho hauríem aconseguit. Sona tòpic, però és cert.</p>
                              <p>Tanmateix i sobretot, el que més ens ha importat ha estat la qualitat del nostre producte. Sempre ens hem preocupat per aprendre i millorar, i per això hem visitat i conegut forners i fleques que ens han aportat tècniques, mètodes, il·lusió i passió per l'ofici. Com la petita fleca regentada per un sol forner, l'Stephane, un projecte preciós del sud de França del qual gairebé vam ser un mirall durant els dos primers anys: farines ecològiques, massa mare, forn de llenya i un procés molt manual. També, vam tenir la sort de visitar The loaf, un projecte de fleca efímera a Donosti, amb Dan Lepard al capdavant, un forner molt experimentat i millor persona. Ens van obrir les portes a poder treballar 3 dies braç a braç a l'obrador, va ser màgic i increïble, l'oportunitat de pastar, formar i enfornar desenes de pans, viure el ritme real d'un obrador, compartir xerrades amb autèntics cracs com el mateix Dan i els forners que treballaven allà: Iban Yarza, amb qui hem coincidit altres vegades; Pablo Conesa, de Sevilla, que estava de visita, molts panarres casolans..., un autèntic luxe.</p>
                              <p>A poc a poc, ha anat entrant gent nova al projecte, al principi per aprendre i ajudar a l'obrador, després per muntar la fleca-cafeteria al poble i de seguida, per afegir el punt dolç que ens faltava. És aquest un moment important en la nostra petita història, quan vam decidir, amb dues famílies més, convertir La Fogaina, en un projecte cooperatiu, on 5 socis decidim de manera assembleària el nostre futur, tot gestionant l'obrador i la fleca-cafeteria amb l'objectiu de mantenir i millorar la nostra qualitat i la nostra producció, i tenir una feina i sou dignes. Ens hi anem acostant. Quan decideixes convertir un projecte familiar en un projecte cooperatiu assumeixes que comences a treballar en equip, sumant i aportant idees i energia al projecte, i això dóna força i moral en els moments difícils.</p>
                              <p>Estem molt orgullosos del que hem aconseguit fins ara, treballem dur i tenim un producte honest i saludable. La Fogaina és una suma dels qui la formem, de manera que és més viva que mai. Sembla clar que, com fa cada dia la nostra massa mare, continuarem creixent, amb noves idees i encara més sorpreses.
                              Esperem que gaudiu dels nostres productes, del nostre espai i del nostre tracte…</p>",
                    :side_body => "", 
                    :side_body_es => "",
                    :side_body_ca => ""

                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Contact",  # default german title
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
                                :view_template => page_attr[:view_template],
                                :title => page_attr[:title] } ) :
      # For the rest of pages
      Refinery::Page.create!( { :show_in_menu => page_attr[:show_in_menu],
                                :deletable => page_attr[:deletable],
                                :view_template => page_attr[:view_template],
                                :title => page_attr[:title] } )

  finnish_page( page, page_attr )
}

#qui_som_page = Refinery::Page.find_by(:title => "Who are we?")
#raise "Error, there should be a 'Who are we?'' page! See seeds.rb" if qui_som_page == nil
#videos = videos_in_home_page


# Path to images PAN
soca_path = "#{Rails.root.join('app/assets/images/pan/IMG_1523.jpg')}"
pa_pages_path = "#{Rails.root.join('app/assets/images/pan/pa_de_pages.jpg')}"
pa_rustic_path = "#{Rails.root.join('app/assets/images/pan/rustic.jpg')}"
pa_croscat_espelta_path = "#{Rails.root.join('app/assets/images/pan/croscat_espelta.jpg')}"
coca_forner_path = "#{Rails.root.join('app/assets/images/pan/coca_forner.jpg')}"
pa_de_coca_path = "#{Rails.root.join('app/assets/images/pan/pa_de_coca.jpg')}"
pa_brot_negre_path = "#{Rails.root.join('app/assets/images/pan/brot_negre.jpg')}"
pa_bembo_path = "#{Rails.root.join('app/assets/images/pan/bembo.jpg')}"
pa_sense_gluten_path = "#{Rails.root.join('app/assets/images/pan/pa_sense_gluten.jpg')}"
pa_segol_path = "#{Rails.root.join('app/assets/images/pan/segol.jpg')}"
pa_baguette_path = "#{Rails.root.join('app/assets/images/pan/baguette.jpg')}"
pa_de_farro_path = "#{Rails.root.join('app/assets/images/pan/pa_de_farro.jpg')}"

# Images PAN
image_soca = Refinery::Image.create :image => File.new(soca_path)
image_pa_de_pages = Refinery::Image.create :image => File.new(pa_pages_path)
image_pa_rustic = Refinery::Image.create :image => File.new(pa_rustic_path)
image_pa_croscat_espelta = Refinery::Image.create :image => File.new(pa_croscat_espelta_path)
image_coca_forner = Refinery::Image.create :image => File.new(coca_forner_path)
image_pa_de_coca = Refinery::Image.create :image => File.new(pa_de_coca_path)
image_brot_negre = Refinery::Image.create :image => File.new(pa_brot_negre_path)
image_pa_bembo = Refinery::Image.create :image => File.new(pa_bembo_path)
image_pa_sense_gluten = Refinery::Image.create :image => File.new(pa_sense_gluten_path)
image_pa_segol = Refinery::Image.create :image => File.new(pa_segol_path)
image_pa_baguette = Refinery::Image.create :image => File.new(pa_baguette_path)
image_pa_de_farro = Refinery::Image.create :image => File.new(pa_de_farro_path)

# Added by Refinery CMS Breads extension
Refinery::Breads::Engine.load_seed

breads_page = Refinery::Page.find_by(:menu_match => "^/breads.*$")

raise "Error, there should be a breads page! See seeds.rb" if breads_page == nil

breads_page.update!( :title => "Backery" )
breads_page.translations.create!( { :locale => "es", :title => "Horno" } )
breads_page.translations.create!( { :locale => "ca", :title => "Forn" } )

panologia_page = breads_page.children.create!( :title => 'Panologia',
                                               :show_in_menu => true,
                                               :deletable => true )

panologia_page.translations.create!( { :locale => "es", :title => "Panologia" } )
panologia_page.translations.create!( { :locale => "ca", :title => "Panologia" } )

panologia_body_part = panologia_page.parts.create!( { :title => "Body", 
                                                      :body => "<p>Entres a les fosques i encens..., només una mica de llum... És agradable començar la jornada amb aquest silenci i aquesta aroma de l'última fornada i del pa fermentant... són les dues de la matinada.
                                                                El treball avança sense pressa, però sense pausa: comprovem els pans que ja estan esperant el seu torn per entrar al forn, formem les coques, encenem i controlem el foc, vigilem la rebosteria...
                                                                A poc a poc acabem tasques, col·loquem pans en cistells i lleixes, però alhora comencem de nou la massa mare i les masses per al següent torn, l'obrador no para.</p>
                                                               <p>Quan ens pregunten per què és diferent el nostre pa, sempre hi ha uns segons de silenci... Per on començo? El mateix em passa ara davant del paper... Fa dies em van demanar que expliqués 'el pa', el pa de la Fogaina, allò que té de diferent o d'important, del nostre treball diari ... No és que fem una cosa extraordinària, fora del que és normal, només fem pa, però potser si que cal deixar clar quin és el camí que hem decidit prendre, com treballem, perquè els que us acosteu a La Fogaina entengueu una mica millor què esteu comprant.</p>
                                                               <p>De cada punt que tractaré d'explicar a continuació se'n podria escriure un llibre (o uns quants), però intentarem resumir cada un d'aquests 'pilars' sobre els quals se sosté la filosofia del treball a La Fogaina.</p>
                                                               <p><a href='/'>Back to home</a></p>" } )

panologia_body_part.translations.create!( { :locale => "es", 
                                            :body => "<p>Entres a les fosques i encens..., només una mica de llum... És agradable començar la jornada amb aquest silenci i aquesta aroma de l'última fornada i del pa fermentant... són les dues de la matinada.
                                                      El treball avança sense pressa, però sense pausa: comprovem els pans que ja estan esperant el seu torn per entrar al forn, formem les coques, encenem i controlem el foc, vigilem la rebosteria...
                                                      A poc a poc acabem tasques, col·loquem pans en cistells i lleixes, però alhora comencem de nou la massa mare i les masses per al següent torn, l'obrador no para.</p>
                                                     <p>Quan ens pregunten per què és diferent el nostre pa, sempre hi ha uns segons de silenci... Per on començo? El mateix em passa ara davant del paper... Fa dies em van demanar que expliqués 'el pa', el pa de la Fogaina, allò que té de diferent o d'important, del nostre treball diari ... No és que fem una cosa extraordinària, fora del que és normal, només fem pa, però potser si que cal deixar clar quin és el camí que hem decidit prendre, com treballem, perquè els que us acosteu a La Fogaina entengueu una mica millor què esteu comprant.</p>
                                                     <p>De cada punt que tractaré d'explicar a continuació se'n podria escriure un llibre (o uns quants), però intentarem resumir cada un d'aquests 'pilars' sobre els quals se sosté la filosofia del treball a La Fogaina.</p>
                                                     <p><a href='/'>Volver al inicio</a></p>" } )
panologia_body_part.translations.create!( { :locale => "ca", 
                                            :body => "<p>Entres a les fosques i encens..., només una mica de llum... És agradable començar la jornada amb aquest silenci i aquesta aroma de l'última fornada i del pa fermentant... són les dues de la matinada.
                                                      El treball avança sense pressa, però sense pausa: comprovem els pans que ja estan esperant el seu torn per entrar al forn, formem les coques, encenem i controlem el foc, vigilem la rebosteria...
                                                      A poc a poc acabem tasques, col·loquem pans en cistells i lleixes, però alhora comencem de nou la massa mare i les masses per al següent torn, l'obrador no para.</p>
                                                     <p>Quan ens pregunten per què és diferent el nostre pa, sempre hi ha uns segons de silenci... Per on començo? El mateix em passa ara davant del paper... Fa dies em van demanar que expliqués 'el pa', el pa de la Fogaina, allò que té de diferent o d'important, del nostre treball diari ... No és que fem una cosa extraordinària, fora del que és normal, només fem pa, però potser si que cal deixar clar quin és el camí que hem decidit prendre, com treballem, perquè els que us acosteu a La Fogaina entengueu una mica millor què esteu comprant.</p>
                                                     <p>De cada punt que tractaré d'explicar a continuació se'n podria escriure un llibre (o uns quants), però intentarem resumir cada un d'aquests 'pilars' sobre els quals se sosté la filosofia del treball a La Fogaina.</p>
                                                     <p><a href='/'>Tornar a l'inici</a></p>" } )

panes = [ 
          { 
            :name_ca => "La Soca", 
            :name_es => "La Soca",
            :name_en => "La Soca",  
            :description_ca => "<p>Pa integral de motlle amb cereals i llavors. Aquest pa és el millor per a fer torrades contundents i acompanyar qualsevol menjar.</p>
                                <p>Pa de llarga fermentació. El podriem considerar un multicereals, amb una farina de molí de pedra i de primera qualitat (blat del cor, xeixa, montcada,espelta...). Tot això fa un pa gustosíssim. Baix en gluten.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => nil,
            :photo => image_soca
          },
          { :name_ca => "Pa de pagés", 
            :name_es => "Pan de pagés",
            :name_en => "Pa de pagés",  
            :description_ca => "<p>Pa rodó amb farina blanca ecològica. Massa mare i una mica de llevat. Es el pa de tota la vida però amb caràcter i molt de gust. Pels que no volen renunciar a fer un pa amb tomàquet o sucar a salses i ous ferrats ...</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => nil,
            :photo => image_pa_de_pages
          },
          { :name_ca => "Rústic", 
            :name_es => "Rústico",
            :name_en => "Rustic",  
            :description_ca => "<p>Pa amb forma de batard, amb farina blanca ecològica, i una mica de farina sègol i blat integral. Massa mare. Es un pa amb una fermentació retardada i molt lenta, que fa que tingui un gust pronunciat a cereals, crosta rústica i molla cremosa.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 3,
            :photo => image_pa_rustic
          },
          { :name_ca => "Tinosell", 
            :name_es => "Tinosell",
            :name_en => "Tinosell",  
            :description_ca => "<p>Mateixa massa del Rústic però amb deliciosos trocets de panses nous i albercoc. Format Motllo. Només massa mare.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 4,
            :photo => nil 
          },
          { :name_ca => "Croscat Espelta", 
            :name_es => "Croscat Espelta",
            :name_en => "Croscat Espelta",  
            :description_ca => "<p>Panet rodó d'espelta amb semilles de girasol i sèsam. Només farina integral i semiintegral d'espelta molta amb molí de pedra. Massa mare d'espelta.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 4.30,
            :photo => image_pa_croscat_espelta 
          },
          { :name_ca => "Coca de forner", 
            :name_es => "Coca de forner",
            :name_en => "Coca de forner",  
            :description_ca => "<p>Coca de oli d'oliva, sucre i anís. Bona alveolatura, tendra i caramelitzada a toc de foc.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 3.10,
            :photo => image_coca_forner 
          },
          { :name_ca => "Pa de coca", 
            :name_es => "Pa de coca",
            :name_en => "Pa de coca",  
            :description_ca => "<p>Aqui trobareu el millor amic per fer unes torrades amb pa amb tomàquet 
                                iniigual.lables. Cuït amb flama directa.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 2.60,
            :photo => image_pa_de_coca 
          },
          { :name_ca => "Brot Negre", 
            :name_es => "Brot Negre",
            :name_en => "Brot Negre",  
            :description_ca => "<p>Pa de segle de motlle petit. 100%  de ségol integral. Molt molt aromàtic. 
                                Es pot combinar amb aliments de gustos forts i contrastats. Però si ets un amant del segle, te'l menjaràs sol!!
                                El sègol es un cereal del qual obtenim una farina mol baixa en gluten. </p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => :no_mostrar,
            :price => nil,
            :photo => image_brot_negre 
          },
          { :name_ca => "Bembó", 
            :name_es => "Bembó",
            :name_en => "Bembó",  
            :description_ca => "<p>Pa de motllo blanc típic per fer 'bikinis' o torrades dolces. Un pa molt tendre, suau però amb una miga més sabrosa que les industrials, gracies a l'elaboració amb massa mare. Porta sucre moré panela, mantega i llet ecològica.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:wednesday, :thursday],
            :price => 4,
            :photo => image_pa_bembo 
          },
          { :name_ca => "Pa sense gluten", 
            :name_es => "Pan sin gluten",
            :name_en => "Bread gluten-free",  
            :description_ca => "<p>Davant de tanta demanda ens animem a fer aquest pa sense gluten (*pot contenir traces, no apte per celíacs), amb farines ecológiques i moltes a la pedra de Fajol (blat sarraí), Arrós Integral i Cigró. També amb midó de tapioca i Maicena Ecológica. Per donar més sabor li possem llavors de chia, llí i sésam. El format es en motllo i intentem, encara que no te gluten, aconseguir una textura i estructura suau i esponjosa. Un pa molt saludable per tothom.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => :por_encargo,
            :price => 6,
            :photo => image_pa_sense_gluten 
          },
          { :name_ca => "Ségol - Blat amb panses i nous", 
            :name_es => "Ségol - Blat amb panses i nous",
            :name_en => "Ségol - Blat amb panses i nous",  
            :description_ca => "<p>Un pa de farina semi integral de blat, amb molta molta massa mare de ségol. </p>
                                <p>Acompanyat amb panses i nous en quantitat. Un pa molt aromàtic i de bona conservació. Un plaer acompanyant tant formatges i fumats com mermelades.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:friday],
            :price => 3.80,
            :photo => image_pa_segol 
          },
          { :name_ca => "Baguette", 
            :name_es => "Baguette",
            :name_en => "Baguette",  
            :description_ca => "<p>Baguettes amb formula de tradició francesa, amb farines de blat moltes a la pedra, massa mare i llevat. Fermentacions llargues i cuita al forn de llenya.</p>
                                <p>Per fi gaudim de les barres a la Fogaina.</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => [:wednesday, :friday, :saturday],
            :price => 1.70,
            :photo => image_pa_baguette 
          },
          { :name_ca => "Pa de Farro", 
            :name_es => "Pa de Farro",
            :name_en => "Pa de Farro",  
            :description_ca => "<p>El Farro (blat de moro) es un producte típic de la Vall d'en Bas, una vall fertil pel 
                                cultiu d'aquest cereal. Malauradament avui dia es dificil de trobar Farro de varietats locals i ecológic, per desgracia els trangénics van guanyant terreny. Ara mateix estem utilitzant Farro de la Vall de Bianya de varietat local.</p>
                                <p>Es un pa suau i fi, un punt dolcet, una miga amb un color crema grogenc que fa contrast amb una crosta deliciosa de color daurat. Tasteu!!</p>",
            :description_es => "<p>Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.</p>",
            :description_en => "<p>Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.</p>",
            :available_days => :por_encargo,
            :price => 2.70,
            :photo => image_pa_de_farro 
          }
        ]

panes.each do |pan_attr|
  pan = Refinery::Breads::Bread.create!( :name => pan_attr[:name_en], 
                                         :description => pan_attr[:description_en],
                                         :available_days => pan_attr[:available_days],
                                         :price => pan_attr[:price],
                                         :photo => pan_attr[:photo],
                                         :locale => "en" )

  pan.translations.create!( :refinery_bread_id => pan.id,
                            :locale => "ca",
                            :name => pan_attr[:name_ca],
                            :description => pan_attr[:description_ca] )

  pan.translations.create!( :refinery_bread_id => pan.id,
                            :locale => "es",
                            :name => pan_attr[:name_es],
                            :description => pan_attr[:description_es] )

end
# Added by Refinery CMS News engine
Refinery::News::Engine.load_seed


news_page = Refinery::Page.find_by(:menu_match => "^/news.*$")

raise "Error, there should be a news page! See seeds.rb" if news_page == nil

news_page.update!( :title => "Activities" )

news_page.translations.create!( { :locale => "es", :title => "Actividades" } )
news_page.translations.create!( { :locale => "ca", :title => "Activitats" } )

oclot_path = "#{Rails.root.join('app/assets/images/news/fogaina_presentacio_600x450.jpg')}"
espai_path = "#{Rails.root.join('app/assets/images/cafeteria/espai.jpg')}"
cursos_cartell_path = "#{Rails.root.join('app/assets/images/cursos/cursos_cartell.jpg')}"

# Images used in news
image_oclot = Refinery::Image.create :image => File.new(oclot_path)
image_espai= Refinery::Image.create :image => File.new(espai_path)
image_cursos_cartell = Refinery::Image.create :image => File.new(cursos_cartell_path)

noticias = [ 
  {
    title_ca: "La Fogaina-Oclot. Servei d'entrega ecològic", 
    title_en: "La Fogaina-Oclot. Organic delivery system.",
    title_es: "La Fogaina-Oclot. Servicio de entrega ecológico.",  
    body_ca: "<p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).</p>
           <p>Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
           A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646.879.062
           Salut, Pa i Pedals!!!</p>", 
    body_en: "<p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).</p>
           <p>Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
           A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646.879.062
           Salut, Pa i Pedals!!!</p>",
    body_es: "<p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).</p>
           <p>Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
           A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646.879.062
           Salut, Pa i Pedals!!!</p>",
    publish_date: DateTime.now,
    photo_id: image_oclot.id  
  },
  {
    title_ca: "Cursos de pa a la Fogaina febrer-abril 2015",
    title_en: "Bread Courses at la Fogaina february-april 2015",
    title_es: "Cursos de pan en la Fogaina febrero-abril 2015", 
    body_ca: "<p>Aquí teniu els cursos per aquests primers mesos del 2015. Ja feia temps que no preparàvem una de grossa, i ara ja amb forces després de les minivacances tornem amb moltes ganes!!</p>
           <p>Hem preparat 3 tipus de cursos d'un matí i 1 experiència de tot el dia, per apendre i gaudir del mon panarra i de la fantàstica ubicació de La Fogaina, al bell mig de la Vall d'en Bas.
           Mes info a la pestanya de 'cursos'.</p>", 
    body_en: "<p>Aquí teniu els cursos per aquests primers mesos del 2015. Ja feia temps que no preparàvem una de grossa, i ara ja amb forces després de les minivacances tornem amb moltes ganes!!</p>
           <p>Hem preparat 3 tipus de cursos d'un matí i 1 experiència de tot el dia, per apendre i gaudir del mon panarra i de la fantàstica ubicació de La Fogaina, al bell mig de la Vall d'en Bas.
           Mes info a la pestanya de 'cursos'.</p>", 
    body_es: "<p>Aquí teniu els cursos per aquests primers mesos del 2015. Ja feia temps que no preparàvem una de grossa, i ara ja amb forces després de les minivacances tornem amb moltes ganes!!</p>
           <p>Hem preparat 3 tipus de cursos d'un matí i 1 experiència de tot el dia, per apendre i gaudir del mon panarra i de la fantàstica ubicació de La Fogaina, al bell mig de la Vall d'en Bas.
           Mes info a la pestanya de 'cursos'.</p>", 
    publish_date: DateTime.now,
    photo_id: image_cursos_cartell.id  
  },
  {
    title_ca: "La Fogaina Pa i Cafe obre les portes",
    title_en: "La Fogaina Pa i Cafe opens its doors",
    title_es: "La Fogaina Pa i Cafe abre sus puertas", 
    body_ca: "<p>Ja hem inaugurat el nou espai de la Fogaina, es diu La Fogaina Pa i Cafè. Hem estat un parell de mesos superestresats i molt liats per poder tirar endavant aquest nou projecte, i aquesta vegada ens hem buscat uns socis lamardemacus, l'Emili i la Joana, i compartim de manera cooperativa, el funcionament del nou espai.</p>
           <p>La Fogaina, Pa i Cafè, l'hem obert a un petit local a Les Preses, a la Vall d'en Bas, només a 3 km de distancia d'on tenim l'obrador, així que cada dia de dimarts a dissabte (8:00 a 13:30, i 16:00 a 20:00) tenim productes recent fets al nostre forn de llenya, per que els acompanyeu amb un bon cafè o una cervesseta artesana i local.
           També hem ampliat la nostra oferta panarra, fem mes varietat mes dies a la setmana, i sobretot hem començat a fer mes dolços: Magdalenes, galetes, croissants, briox, coques etc.
           Si voleu mes info, cliqueu a la pestanyeta que posa Pa i Cafè mes amunt.
           I el pròxim dia 11 d'octubre fem una festeta d'apertura coincidint amb les festes del poble!!</p>", 
    body_en: "<p>Ja hem inaugurat el nou espai de la Fogaina, es diu La Fogaina Pa i Cafè. Hem estat un parell de mesos superestresats i molt liats per poder tirar endavant aquest nou projecte, i aquesta vegada ens hem buscat uns socis lamardemacus, l'Emili i la Joana, i compartim de manera cooperativa, el funcionament del nou espai.</p>
           <p>La Fogaina, Pa i Cafè, l'hem obert a un petit local a Les Preses, a la Vall d'en Bas, només a 3 km de distancia d'on tenim l'obrador, així que cada dia de dimarts a dissabte (8:00 a 13:30, i 16:00 a 20:00) tenim productes recent fets al nostre forn de llenya, per que els acompanyeu amb un bon cafè o una cervesseta artesana i local.
           També hem ampliat la nostra oferta panarra, fem mes varietat mes dies a la setmana, i sobretot hem començat a fer mes dolços: Magdalenes, galetes, croissants, briox, coques etc.
           Si voleu mes info, cliqueu a la pestanyeta que posa Pa i Cafè mes amunt.
           I el pròxim dia 11 d'octubre fem una festeta d'apertura coincidint amb les festes del poble!!</p>", 
    body_es: "<p>Ja hem inaugurat el nou espai de la Fogaina, es diu La Fogaina Pa i Cafè. Hem estat un parell de mesos superestresats i molt liats per poder tirar endavant aquest nou projecte, i aquesta vegada ens hem buscat uns socis lamardemacus, l'Emili i la Joana, i compartim de manera cooperativa, el funcionament del nou espai.</p>
           <p>La Fogaina, Pa i Cafè, l'hem obert a un petit local a Les Preses, a la Vall d'en Bas, només a 3 km de distancia d'on tenim l'obrador, així que cada dia de dimarts a dissabte (8:00 a 13:30, i 16:00 a 20:00) tenim productes recent fets al nostre forn de llenya, per que els acompanyeu amb un bon cafè o una cervesseta artesana i local.
           També hem ampliat la nostra oferta panarra, fem mes varietat mes dies a la setmana, i sobretot hem començat a fer mes dolços: Magdalenes, galetes, croissants, briox, coques etc.
           Si voleu mes info, cliqueu a la pestanyeta que posa Pa i Cafè mes amunt.
           I el pròxim dia 11 d'octubre fem una festeta d'apertura coincidint amb les festes del poble!!</p>", 
    publish_date: DateTime.now,
    photo_id: image_espai.id  
  },
  # {
  #   title_ca: "Festa panarra final de curs",
  #   title_en: "Panarra party end of the course",
  #   title_es: "Fiesta panarra final de curso", 
  #   body_ca: "<p>Ja queden pocs dies per la cel.lebració de la Festa Panarra que tindrà lloc al nostre Forn. Després d'un estiu molt mogut amb diferents cursos de pa, toca fer una mica de gresca.
  #             El dia senyalat: Diumenge 29 de septembre
  #             Hora: A partir de les 11:00h (mes o menys) i fins les 20:00 (mes o menys també)
  #             Qui pot venir: Tothom que li agradi el bon pa, la bona cervessa, la bona música... sempre amb respecte i \"saber estar\".
  #             Que s'ha de portar?: No es obligatori però podeu portar algo per compartir tipus menjar de primer plat (cosetes bones per vacil.lar jeje), o alguna beguda chupi, o algun postre requetechupi. I per descomptat bon humor i ganes de ballar si cal!!!.
  #             I pels panarras tindrem preparada una taula exclusiva només per pans. Així que podeu portar un pa fet a casa perque fem una bona degustació tothom (no serà concurs).
  #             Els músics podeu portar el vostre instrument (si es acústic) per acompanyar l'acordió la flauta travessera i el banjo que segur que estaràn.
  #             Que us trobareu?: Tindrem un parell de barrils de cervessa artesana de la bona. Una taula amb pica pica i menjars que portarem entre tots. Una barbacoa amb carn de la garrotxa. Música en directe folk... i bon pa!!</p>", 
  #   body_en: "<p>Ja queden pocs dies per la cel.lebració de la Festa Panarra que tindrà lloc al nostre Forn. Després d'un estiu molt mogut amb diferents cursos de pa, toca fer una mica de gresca.
  #             El dia senyalat: Diumenge 29 de septembre
  #             Hora: A partir de les 11:00h (mes o menys) i fins les 20:00 (mes o menys també)
  #             Qui pot venir: Tothom que li agradi el bon pa, la bona cervessa, la bona música... sempre amb respecte i \"saber estar\".
  #             Que s'ha de portar?: No es obligatori però podeu portar algo per compartir tipus menjar de primer plat (cosetes bones per vacil.lar jeje), o alguna beguda chupi, o algun postre requetechupi. I per descomptat bon humor i ganes de ballar si cal!!!.
  #             I pels panarras tindrem preparada una taula exclusiva només per pans. Així que podeu portar un pa fet a casa perque fem una bona degustació tothom (no serà concurs).
  #             Els músics podeu portar el vostre instrument (si es acústic) per acompanyar l'acordió la flauta travessera i el banjo que segur que estaràn.
  #             Que us trobareu?: Tindrem un parell de barrils de cervessa artesana de la bona. Una taula amb pica pica i menjars que portarem entre tots. Una barbacoa amb carn de la garrotxa. Música en directe folk... i bon pa!!</p>", 
  #   body_es: "<p>Ja queden pocs dies per la cel.lebració de la Festa Panarra que tindrà lloc al nostre Forn. Després d'un estiu molt mogut amb diferents cursos de pa, toca fer una mica de gresca.
  #             El dia senyalat: Diumenge 29 de septembre
  #             Hora: A partir de les 11:00h (mes o menys) i fins les 20:00 (mes o menys també)
  #             Qui pot venir: Tothom que li agradi el bon pa, la bona cervessa, la bona música... sempre amb respecte i \"saber estar\".
  #             Que s'ha de portar?: No es obligatori però podeu portar algo per compartir tipus menjar de primer plat (cosetes bones per vacil.lar jeje), o alguna beguda chupi, o algun postre requetechupi. I per descomptat bon humor i ganes de ballar si cal!!!.
  #             I pels panarras tindrem preparada una taula exclusiva només per pans. Així que podeu portar un pa fet a casa perque fem una bona degustació tothom (no serà concurs).
  #             Els músics podeu portar el vostre instrument (si es acústic) per acompanyar l'acordió la flauta travessera i el banjo que segur que estaràn.
  #             Que us trobareu?: Tindrem un parell de barrils de cervessa artesana de la bona. Una taula amb pica pica i menjars que portarem entre tots. Una barbacoa amb carn de la garrotxa. Música en directe folk... i bon pa!!</p>", 
  #   publish_date: DateTime.now,
  #   photo_id: nil 
  # },
  # {
  #   title_ca: "Curs rebosteria panadera",
  #   title_en: "Pastry course",
  #   title_es: "Curso reposteria panadera", 
  #   body_ca: "<p>Aún de calentón y ya con ganas de contaros como ha ido el curso de Reposteria Panadera con Chema de Forn Pedreres.
  #             Ha sido un curso intenso de todo el dia laborando en el obrador, lxs chicxs apuntadxs al curso se han aplicado pero bien bien.
  #             Chema nos tenia preparados una buena tanda de recetas a elaborar: Croissants (pequeños, grandes, xocolate, xoricillo...), magdalenas, coca de forner y coca de vidre.</p>", 
  #   body_en: "<p>Aún de calentón y ya con ganas de contaros como ha ido el curso de Reposteria Panadera con Chema de Forn Pedreres.
  #             Ha sido un curso intenso de todo el dia laborando en el obrador, lxs chicxs apuntadxs al curso se han aplicado pero bien bien.
  #             Chema nos tenia preparados una buena tanda de recetas a elaborar: Croissants (pequeños, grandes, xocolate, xoricillo...), magdalenas, coca de forner y coca de vidre.</p>", 
  #   body_es: "<p>Aún de calentón y ya con ganas de contaros como ha ido el curso de Reposteria Panadera con Chema de Forn Pedreres.
  #             Ha sido un curso intenso de todo el dia laborando en el obrador, lxs chicxs apuntadxs al curso se han aplicado pero bien bien.
  #             Chema nos tenia preparados una buena tanda de recetas a elaborar: Croissants (pequeños, grandes, xocolate, xoricillo...), magdalenas, coca de forner y coca de vidre.</p>", 
  #   publish_date: DateTime.now,
  #   photo_id: nil 
  # }
]

noticias.each do |noticia_attr|

  noticia = Refinery::News::Item.create!( 
    locale: "en", 
    title: noticia_attr[:title_en], 
    body: noticia_attr[:body_en], 
    publish_date: noticia_attr[:publish_date],
    photo_id: noticia_attr[:photo_id] )

  noticia.translations.create!( { :refinery_news_item_id => noticia.id,
                                  :locale => "ca",
                                  :title => noticia_attr[:title_ca], 
                                  :body => noticia_attr[:body_ca] } )

  noticia.translations.create!( { :refinery_news_item_id => noticia.id,
                                  :locale => "es",
                                  :title => noticia_attr[:title_es],
                                  :body => noticia_attr[:body_es] } )
end



# Added by Refinery CMS CafeteriaCategories extension
Refinery::CafeteriaCategories::Engine.load_seed

cafeteria_page = Refinery::Page.find_by(:title => "Cafeteria")

raise "Error, there should be a cafeteria page! See seeds.rb" if cafeteria_page == nil

cafeteria_page.translations.create!( { :locale => "es", :title => "Cafetería" } )
cafeteria_page.translations.create!( { :locale => "ca", :title => "Cafeteria" } )

cafe_path = "#{Rails.root.join('app/assets/images/cafe/coffee800x800.jpg')}"
entrepans_path = "#{Rails.root.join('app/assets/images/entrepans/IMG_2872.jpg')}"
sucs_i_tees_path = "#{Rails.root.join('app/assets/images/sucs_i_tees/IMG_2603.jpg')}"
reposteria_path = "#{Rails.root.join('app/assets/images/reposteria/IMG_2178.jpg')}"
image_cafe = Refinery::Image.create :image => File.new(cafe_path)
image_entrepans = Refinery::Image.create :image => File.new(entrepans_path)
image_sucs_i_tees = Refinery::Image.create :image => File.new(sucs_i_tees_path)
image_reposteria = Refinery::Image.create :image => File.new(reposteria_path)

categories_cafeteria = [ 
  {
    title_ca: "Cafes", 
    title_en: "Coffee",
    title_es: "Cafes",  
    description_ca: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam esse quisquam est debitis inventore, distinctio, sunt molestiae, numquam assumenda ut libero quam nisi saepe, laborum vel perspiciatis repellat aspernatur. Nihil.</p><p>Enim iste facere quo pariatur, temporibus debitis maxime id illo repellat cumque velit ea modi, sit impedit, aperiam accusantium libero quisquam explicabo, earum voluptates dolore autem. Tempora aut officiis ex?</p>", 
    description_en: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore, aliquid sed cupiditate perferendis eum ab optio expedita fugit error omnis suscipit laborum, aperiam, nemo nisi excepturi tempore. Repellendus provident, optio.</p>",
    description_es: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis cumque illo nesciunt vel voluptatibus explicabo magni sit tempore eos dolore ut doloremque, repellendus. Perspiciatis a beatae voluptatum hic, eos quia.</p>",
    image: image_cafe  
  },
  {
    title_ca: "Sucs i Tees", 
    title_en: "Juices and tees",
    title_es: "Zumos i Tees",  
    description_ca: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam esse quisquam est debitis inventore, distinctio, sunt molestiae, numquam assumenda ut libero quam nisi saepe, laborum vel perspiciatis repellat aspernatur. Nihil.</p><p>Enim iste facere quo pariatur, temporibus debitis maxime id illo repellat cumque velit ea modi, sit impedit, aperiam accusantium libero quisquam explicabo, earum voluptates dolore autem. Tempora aut officiis ex?</p>", 
    description_en: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore, aliquid sed cupiditate perferendis eum ab optio expedita fugit error omnis suscipit laborum, aperiam, nemo nisi excepturi tempore. Repellendus provident, optio.</p>",
    description_es: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis cumque illo nesciunt vel voluptatibus explicabo magni sit tempore eos dolore ut doloremque, repellendus. Perspiciatis a beatae voluptatum hic, eos quia.</p>",
    image: image_sucs_i_tees  
  },
  {
    title_ca: "Entrepans", 
    title_en: "Sandwitches",
    title_es: "Bocadillos",  
    description_ca: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam esse quisquam est debitis inventore, distinctio, sunt molestiae, numquam assumenda ut libero quam nisi saepe, laborum vel perspiciatis repellat aspernatur. Nihil.</p><p>Enim iste facere quo pariatur, temporibus debitis maxime id illo repellat cumque velit ea modi, sit impedit, aperiam accusantium libero quisquam explicabo, earum voluptates dolore autem. Tempora aut officiis ex?</p>", 
    description_en: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore, aliquid sed cupiditate perferendis eum ab optio expedita fugit error omnis suscipit laborum, aperiam, nemo nisi excepturi tempore. Repellendus provident, optio.</p>",
    description_es: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis cumque illo nesciunt vel voluptatibus explicabo magni sit tempore eos dolore ut doloremque, repellendus. Perspiciatis a beatae voluptatum hic, eos quia.</p>",
    image: image_entrepans  
  },
  {
    title_ca: "Cerveses", 
    title_en: "Beers",
    title_es: "Cervezas",  
    description_ca: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam esse quisquam est debitis inventore, distinctio, sunt molestiae, numquam assumenda ut libero quam nisi saepe, laborum vel perspiciatis repellat aspernatur. Nihil.</p><p>Enim iste facere quo pariatur, temporibus debitis maxime id illo repellat cumque velit ea modi, sit impedit, aperiam accusantium libero quisquam explicabo, earum voluptates dolore autem. Tempora aut officiis ex?</p>", 
    description_en: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore, aliquid sed cupiditate perferendis eum ab optio expedita fugit error omnis suscipit laborum, aperiam, nemo nisi excepturi tempore. Repellendus provident, optio.</p>",
    description_es: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis cumque illo nesciunt vel voluptatibus explicabo magni sit tempore eos dolore ut doloremque, repellendus. Perspiciatis a beatae voluptatum hic, eos quia.</p>",
    image: image_pa_rustic  
  },
  {
    title_ca: "Rebosteria", 
    title_en: "Cakes",
    title_es: "Repostería",  
    description_ca: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam esse quisquam est debitis inventore, distinctio, sunt molestiae, numquam assumenda ut libero quam nisi saepe, laborum vel perspiciatis repellat aspernatur. Nihil.</p><p>Enim iste facere quo pariatur, temporibus debitis maxime id illo repellat cumque velit ea modi, sit impedit, aperiam accusantium libero quisquam explicabo, earum voluptates dolore autem. Tempora aut officiis ex?</p>", 
    description_en: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore, aliquid sed cupiditate perferendis eum ab optio expedita fugit error omnis suscipit laborum, aperiam, nemo nisi excepturi tempore. Repellendus provident, optio.</p>",
    description_es: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis cumque illo nesciunt vel voluptatibus explicabo magni sit tempore eos dolore ut doloremque, repellendus. Perspiciatis a beatae voluptatum hic, eos quia.</p>",
    image: image_reposteria  
  }
]

categories_cafeteria.each do |category_attr|

  category = Refinery::CafeteriaCategories::CafeteriaCategory.create!( 
    locale: "en", 
    title: category_attr[:title_en], 
    description: category_attr[:description_en], 
    image: category_attr[:image] )

  category.translations.create!( { :refinery_cafeteria_category_id => category.id, 
                                   :locale => "ca",
                                   :title => category_attr[:title_ca], 
                                   :description => category_attr[:description_ca] } )

  category.translations.create!( { :refinery_cafeteria_category_id => category.id,
                                   :locale => "es",
                                   :title => category_attr[:title_es], 
                                   :description => category_attr[:description_es]  } )
end

# Added by Refinery CMS Videos extension
Refinery::Videos::Engine.load_seed

videos_page = Refinery::Page.find_by(:title => "Videos")

raise "Error, there should be a videos page! See seeds.rb" if videos_page == nil

videos_page.translations.create!( { :locale => "es", :title => "Videos" } )
videos_page.translations.create!( { :locale => "ca", :title => "Videos" } )

videos_page.update!( :show_in_menu => false )

Refinery::Videos::Video.create!( :title => "Fogaina coope",
                          :address => "https://www.youtube.com/embed/sTon2EsQOvY" )

Refinery::Videos::Video.create!( :title => "Fogaina",
                          :address => "https://www.youtube.com/embed/qC_hegFxyb4" )
