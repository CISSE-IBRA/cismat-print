# Generated by Django 5.2.1 on 2025-06-30 10:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('web_site', '0007_service_image'),
    ]

    operations = [
        migrations.CreateModel(
            name='Service_ModelOptionValue',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('valeur', models.CharField(help_text='Ex: Rouge, A4, Haute qualité', max_length=100)),
            ],
            options={
                'verbose_name': "Valeur d'option",
                'verbose_name_plural': "Valeurs d'options",
            },
        ),
        migrations.RemoveField(
            model_name='service_modeldetail',
            name='valeurs_possibles',
        ),
        migrations.AddField(
            model_name='service_modeldetail',
            name='valeurs_possibles',
            field=models.ManyToManyField(blank=True, help_text='Sélectionnez les valeurs possibles pour cette option (pour SELECT, RADIO, CHECKBOX)', to='web_site.service_modeloptionvalue'),
        ),
    ]
