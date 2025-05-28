import { createClient } from '@supabase/supabase-js';

(async () => {
  const supabaseUrl = process.env.SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_KEY;
  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    const { data: files, error: listError } = await supabase
      .storage
      .from('blogs')
      .list('', { limit: 100 });

    if (listError) throw listError;
    if (!files || files.length === 0) throw new Error('No files found in blogs bucket');

    function getRandomElements(arr, count) {
      const shuffled = [...arr].sort(() => 0.5 - Math.random());
      return shuffled.slice(0, count);
    }

    const selectedFiles = getRandomElements(files, 3);

    const imageUrls = selectedFiles.map(f => `${supabaseUrl}/storage/v1/object/public/blogs/${encodeURIComponent(f.name)}`);

    const keys = ['home_view_image1', 'home_view_image2', 'home_view_image3'];

    for (let i = 0; i < keys.length; i++) {
      const key = keys[i];
      const value = imageUrls[i] || null;

      const { error: upsertError } = await supabase
        .from('app_metadata')
        .upsert({ key, value }, { onConflict: 'key' });

      if (upsertError) throw upsertError;
      console.log(`Updated ${key} to ${value}`);
    }

    console.log('Home view images updated successfully.');
  } catch (err) {
    console.error('Error updating home view images:', err);
    process.exit(1);
  }
})();
