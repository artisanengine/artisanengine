# ------------------------------------------------------------------
# Rewrite URLs for SEO purposes.

Rails.application.config.middleware.insert_before( Rack::Lock, Rack::Rewrite ) do
  
  # ------------------------------------------------------------------
  # Peggy Skemp Jewelry
  
  r301 '/silver-anatomical-heart-locket-p7',        '/goods/silver-anatomical-heart-locket'
  r301 '/anatomical-d2',                            '/collections/anatomical'
  r301 '/original-anatomical-heart-necklace-p9',    '/goods/original-anatomical-heart-necklace'
  r301 '/18ky-diamond-anatomical-heart-locket-p10', '/goods/18ky-diamond-anatomical-heart-locket'
  r301 '/half-heart-necklace-p47',                  '/goods/half-heart-necklace'
  r301 '/tentacles-d3',                             '/collections/tentacles'
  r301 '/silver-tentacle-ring-p28',                 '/goods/silver-tentacle-band'
  r301 '/anatomical-lung-locket-p12',               '/goods/anatomical-lung-locket'
  r301 '/rufous-rubbercup-ring-p39',                '/goods/rufous-rubbercup-ring'
end