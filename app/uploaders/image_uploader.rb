# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper


  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  # ActionController::Base.helpers.asset_path("images/fallback/" + [version_name, "default_image.png"].compact.join('_'))
  # asset_path("/fallback/" + [version_name, "default_image.png"].compact.join('_'))
    # "/fallback/" + [version_name, "default_image.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]

  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :admin_thumb do
    process resize_to_fit: [500, 500]
  end

  version :user_thumb do
    process resize_to_fit: [500, 500]
  end

  version :big_image do
    process resize_to_fit: [450, 500]
  end

  version :feature do
    process resize_to_fit: [800, 500]
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end